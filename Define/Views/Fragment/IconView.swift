//
//  IconView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2022.
//

import SwiftUI

/// Image with a gradient background
struct IconView: View {

    /// Icon image
    var image: Image

    var body: some View {
        ZStack {
            LinearGradient(
                colors: .blue,
                startPoint: .leading,
                endPoint: .trailing
            )

            image
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.appWhite)
                .frame(width: .iconSize, height: .iconSize)
        }
    }
}

// MARK: - PreviewProvider

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(image: .search)
    }
}
