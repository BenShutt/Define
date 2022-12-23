//
//  AppNavigationLink.swift
//  Define
//
//  Created by Ben Shutt on 23/12/2022.
//

import SwiftUI

/// `NavigationLink` with default styling
struct AppNavigationLink<Destination: View, Label: View>: View {

    /// `Destination`
    @ViewBuilder var destination: () -> Destination

    /// `Label`
    @ViewBuilder var label: () -> Label

    var body: some View {
        ZStack {
            NavigationLink(destination: destination()) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)

            label()
        }
    }
}

// MARK: - Extensions

extension AppNavigationLink {

    /// Initialize with `destination` and `label`
    /// - Parameters:
    ///   - destination: `Destination`
    ///   - label: `Label` mapping
    init(destination: Destination, label: @escaping () -> Label) {
        self.init(destination: { destination }, label: label)
    }
}
