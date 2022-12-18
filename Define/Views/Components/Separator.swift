//
//  Separator.swift
//  Define
//
//  Created by Ben Shutt on 18/12/2022.
//

import SwiftUI

/// Separator line
struct Separator: View {

    var body: some View {
        Rectangle() // Separator
            .fill(Color.appLightGray)
            .frame(height: 2)
    }
}
