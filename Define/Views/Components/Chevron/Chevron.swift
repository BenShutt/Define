//
//  Chevron.swift
//  Define
//
//  Created by Ben Shutt on 19/12/2022.
//

import SwiftUI

// TODO: SFSymbol?

/// A chevron shape
struct Chevron: Shape {

    /// Draw `Path`
    /// - Parameter rect: `CGRect`
    /// - Returns: `Path`
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.minX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.midY))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        }
    }
}

// MARK: - Preview

#Preview {
    Chevron()
        .stroke(style: StrokeStyle(lineWidth: 50 / 2, lineCap: .round))
        .foregroundColor(.red)
        .frame(width: 50, height: 50 * 2.5)
}
