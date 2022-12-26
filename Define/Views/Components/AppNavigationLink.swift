//
//  AppNavigationLink.swift
//  Define
//
//  Created by Ben Shutt on 23/12/2022.
//

import SwiftUI

/// `NavigationLink` with default styling
struct AppNavigationLink<Value: Hashable, Label: View>: View {

    /// `Value`
    var value: Value

    /// `Label`
    @ViewBuilder var label: () -> Label

    var body: some View {
        ZStack {
            NavigationLink(value: value) { EmptyView() }
                .frame(width: 0)
                .opacity(0)

            label()
        }
    }
}
