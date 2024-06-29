//
//  ChevronView.swift
//  Define
//
//  Created by Ben Shutt on 19/12/2022.
//

import SwiftUI

// TODO: Improve UI

/// `View` drawing a chevron
struct ChevronView: View {
    private let size: CGFloat = 24

    var body: some View {
        Image(systemName: "chevron.right")
            .systemImage(size: size * 2 / 3, weight: .heavy)
            .foregroundStyle(Color.appDarkGray)
            .frame(width: size, height: size)
            .background(Color.appFaintGray)
            .clipShape(.rect(cornerRadius: size / 4))
    }
}

// MARK: - Preview

#Preview {
    ChevronView()
}
