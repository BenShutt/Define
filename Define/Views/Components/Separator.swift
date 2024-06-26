//
//  Separator.swift
//  Define
//
//  Created by Ben Shutt on 18/12/2022.
//

import SwiftUI

/// Horizontal separator line
struct Separator: View {
    var color: Color = .separator

    var body: some View {
        color
            .frame(height: .separator)
    }
}
