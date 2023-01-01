//
//  NumberView.swift
//  Define
//
//  Created by Ben Shutt on 01/01/2023.
//

import SwiftUI

/// Circular number UI
struct NumberView: View {

    /// Nuber to draw
    var number: Int

    /// Draw body
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.appLightGray)

            Text("\(number)")
                .tag()
                .lineLimit(1)
                .minimumScaleFactor(0.25)
                .padding(.extraSmall)
        }
        .frame(.extraLarge)
    }
}

// MARK: - PreviewProvider

struct NumberView_Previews: PreviewProvider {

    static var previews: some View {
        HStack(spacing: .small) {
            NumberView(number: 1)
            NumberView(number: 12)
            NumberView(number: 123)
            NumberView(number: 1234)
            NumberView(number: 12_345)
            NumberView(number: 123_456)
        }
    }
}
