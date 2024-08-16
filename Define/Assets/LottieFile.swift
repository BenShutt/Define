//
//  LottieFile.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import SwiftUI
import Lottie

/// A Lottie asset file
enum LottieFile: String {
    case searchEmpty
    case searchNoResults

    /// Workaround: scale the lottie to remove whitespace on the asset
    var scale: CGFloat {
        switch self {
        case .searchEmpty: 1.5
        case .searchNoResults: 1
        }
    }
}

// MARK: - LottieView + LottieFile

extension LottieView {
    init(_ file: LottieFile) where Placeholder == EmptyView {
        self.init(animation: .named(file.rawValue))
    }
}

// MARK: - View + LottieFile

extension View {
    func transform(lottie: LottieFile) -> some View {
        scaleEffect(x: lottie.scale, y: lottie.scale)
    }
}
