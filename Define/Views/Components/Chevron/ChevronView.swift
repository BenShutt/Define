//
//  ChevronView.swift
//  Define
//
//  Created by Ben Shutt on 19/12/2022.
//

import SwiftUI

/// `View` drawing a chevron
struct ChevronView: View {

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .cornerRadius)
                .fill(Color.appLightGray)
                .frame(32)

            Chevron()
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .foregroundColor(Color.appPrimary)
                .frame(width: 6, height: 14)
        }
    }
}

// MARK: - PreviewProvider

struct ChevronView_Previews: PreviewProvider {

    static var previews: some View {
        ChevronView()
    }
}
