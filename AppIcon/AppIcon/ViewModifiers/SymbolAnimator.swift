//
//  SymbolAnimator.swift
//  AppIcon
//
//  Created by Ben Shutt on 23/06/2024.
//

import SwiftUI

@available(iOS, deprecated: 17, message: "No longer needed")
private struct SymbolAnimator<Value: Equatable>: ViewModifier {
    var value: Value

    func body(content: Content) -> some View {
        if #available(iOS 17, macOS 14, *) {
            content.symbolEffect(.bounce, value: value)
        } else {
            content
        }
    }
}

// MARK: - View + SymbolAnimator

public extension View {
    func bounceSymbol(_ value: Int) -> some View {
        modifier(SymbolAnimator(value: value))
    }
}
