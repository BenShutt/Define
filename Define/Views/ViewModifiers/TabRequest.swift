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

// MARK: - TabRequestPublisher

/// Environment for tab requests
@MainActor class TabRequestPublisher: ObservableObject {

    /// A tab request to publish
    @Published var request: TabRequest?

    /// Publish a new `TabRequest`
    /// - Parameters:
    ///   - tab: Tab to select and update navigation stack
    ///   - action: How to update the navigation stack
    func open(
        tab: Tab,
        action: @escaping TabRequest.Action
    ) {
        // Publish the action to be handled by the tab
        request = TabRequest(tab: tab, action: action)
    }
}

// MARK: - RootObserver

/// Observe the tab requests with the tab binding and handle accordingly
///
/// This is separate from `TabObserver` because the SwiftUI of a tab is
/// is not in memory until it is selected. Therefore, it will not receive onReceive events.
/// We select the tab on the root `TabView` and the request is resolved on first load.
private struct RootObserver: ViewModifier {
    @EnvironmentObject private var publisher: TabRequestPublisher
    @Binding var selectedTab: Tab

    func body(content: Content) -> some View {
        content
            .onReceive(publisher.$request) { request in
                if let request {
                    selectedTab = request.tab
                }
            }
    }
}

// MARK: - TabObserver

/// Observe the tab requests with the navigation environments and handle accordingly
private struct TabObserver: ViewModifier {
    @EnvironmentObject private var publisher: TabRequestPublisher
    @Environment(\.push) private var push
    @Environment(\.popToRoot) private var popToRoot
    var tab: Tab

    func body(content: Content) -> some View {
        content
            .onReceive(publisher.$request) { request in
                if let request, tab == request.tab {
                    request.action(push, popToRoot)
                }
            }
    }
}

// MARK: - View + TabRequestObserver

extension View {
    func observeRootTabRequests(selectedTab: Binding<Tab>) -> some View {
        modifier(RootObserver(selectedTab: selectedTab))
    }

    func observeTabRequests(tab: Tab) -> some View {
        modifier(TabObserver(tab: tab))
    }
}
