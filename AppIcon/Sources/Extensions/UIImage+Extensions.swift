//
//  UIImage+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 06/10/2022.
//

import UIKit

extension UIImage {

    /// Resize `UIImage` instance to `size`
    ///
    /// - Parameters:
    ///   - size: `CGSize`
    ///   - format: `UIGraphicsImageRendererFormat`
    /// - Returns: `UIImage`
    func resize(
        to size: CGSize,
        format: UIGraphicsImageRendererFormat = .default()
    ) -> UIImage {
        UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
