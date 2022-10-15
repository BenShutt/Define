//
//  ListView.swift
//  Define
//
//  Created by Ben Shutt on 15/10/2022.
//

import SwiftUI

/// App usage of `List`
struct ListView<Element: Identifiable, Content: View>: View {

    /// `Identifiable` elements to iterate over
    var elements: [Element]

    /// Map `Element` to `Content`
    @ViewBuilder var content: (Element) -> Content

    /// Make `List` of `Element`s
    var body: some View {
        List(elements) { element in
            content(element)
                .listRowInsets(.zero)
                .listRowSeparator(.automatic)
        }
        .listStyle(.plain)
    }
}
