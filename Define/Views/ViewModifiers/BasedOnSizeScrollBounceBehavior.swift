//
//  BasedOnSizeScrollBounceBehavior.swift
//  Define
//
//  Created by Ben Shutt on 24/06/2024.
//

import SwiftUI

private struct BasedOnSizeScrollBounceBehavior: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            content.scrollBounceBehavior(.basedOnSize)
        } else {
            content
        }
    }
}

extension View {
    func scrollBounceBasedOnSize() -> some View {
        modifier(BasedOnSizeScrollBounceBehavior())
    }
}
