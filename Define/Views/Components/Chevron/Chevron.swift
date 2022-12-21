//
//  Chevron.swift
//  Define
//
//  Created by Ben Shutt on 19/12/2022.
//

import SwiftUI

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

// MARK: - PreviewProvider

struct ChevronProvider_Previews: PreviewProvider {

    private static var width: CGFloat = 50
    private static var height: CGFloat { width * 2.5 }
    private static var lineWidth: CGFloat { width / 2 }

    static var previews: some View {
        Chevron()
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .foregroundColor(.red)
            .frame(width: width, height: height)
    }
}
