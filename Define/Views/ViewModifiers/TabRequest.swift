//
//  Router.swift
//  Define
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI

/// Select a tab and add an action on its navigation stack.
///
/// Because each tab has its own navigation view stack, other tabs must publish
/// this request via a shared environment. The relevant tab receives the request
/// and handles it accordingly.
struct TabRequest {

    /// An action to perform on a navigation stack
    typealias Action = (PushAction, PopToRootAction) -> Void

    /// The tab to select
    var tab: Tab

    /// The action to execute on the navigation stack of the respective tab
    var action: Action
}

// MARK: - SelectTab

/// Invoke a closure to select a tab
struct SelectTab {
    var action: (Tab) -> Void

    func callAsFunction(_ tab: Tab) {
        action(tab)
    }
}

private struct SelectTabKey: EnvironmentKey {
    static let defaultValue: SelectTab = .init { _ in }
}

extension EnvironmentValues {
    var selectTab: SelectTab {
        get { self[SelectTabKey.self] }
        set { self[SelectTabKey.self] = newValue }
    }
}

// MARK: - TabRequestPublisher

/// Environment for tab requests
@MainActor class TabRequestPublisher: ObservableObject {

    /// Environment used to select a tab
    @Environment(\.selectTab) private var selectTab

    /// A tab request to publish, observers will resolve
    @Published var request: TabRequest?

    /// Publish a new `TabRequest`
    /// - Parameters:
    ///   - tab: Tab to select and update navigation stack
    ///   - action: How to update the navigation stack
    func open(
        tab: Tab,
        action: @escaping TabRequest.Action
    ) {
        // Select the tab.
        // This must be set before onReceive so that the view is loaded if
        // it hasn't been already.
        selectTab(tab)

        // Publish the action to be handled by the tab
        request = TabRequest(tab: tab, action: action)
    }
}

// MARK: - TabRequestObserver

/// Observe the tab requests with the navigation environments and handle accordingly
private struct TabRequestObserver: ViewModifier {
    @EnvironmentObject private var publisher: TabRequestPublisher
    @Environment(\.push) private var push
    @Environment(\.popToRoot) private var popToRoot
    var tab: Tab

    func body(content: Content) -> some View {
        content
            .onReceive(publisher.$request) { request in
                guard let request, tab == request.tab else { return }
                request.action(push, popToRoot)
                publisher.request = nil // Mark resolved
            }
    }
}

// MARK: - View + TabRequestObserver

extension View {
    func observeTabRequests(tab: Tab) -> some View {
        modifier(TabRequestObserver(tab: tab))
    }
}
