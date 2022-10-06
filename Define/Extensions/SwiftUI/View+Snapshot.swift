//
//  View+Snapshot.swift
//  Define
//
//  Created by Ben Shutt on 06/10/2022.
//

import SwiftUI

extension View {

    /// Snapshot `UIImage` from this SwiftUI `Viww` instance
    ///
    /// - Warning:
    /// Should be called from the main thread
    ///
    /// - Parameter size: Target `CGSize`
    /// - Returns: `UIImage`
    func snapshot(size: CGSize) -> UIImage {
        // Wrap in UIHostingController
        let hostingController = UIHostingController(rootView: self)

        // Configure view (of viewController) to size
        let view: UIView = hostingController.view
        view.frame = CGRect(origin: .zero, size: size)
        view.backgroundColor = .clear

        // Draw view as image
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        }
    }
}
