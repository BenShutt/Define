//
//  KeyboardToolbar.swift
//  Define
//
//  Created by Ben Shutt on 18/12/2022.
//

import SwiftUI

/// Add toolbar for keyboard
private struct KeyboardToolbar: ViewModifier {

    /// Dismiss button tapped
    var onDismiss: () -> Void

    /// Apply overlay of stroked `RoundedRectangle`
    ///
    /// - Parameter content: `Content`
    /// - Returns: `View`
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("dismiss") {
                    onDismiss()
                }
            }
        }
    }
}

// MARK: View + KeyboardToolbar

extension View {

    /// Add `KeyboardToolbar` modifier
    /// - Parameter onDismiss: Dismiss tap handler
    /// - Returns: `View`
    func keyboardToolbar(onDismiss: @escaping () -> Void) -> some View {
        modifier(KeyboardToolbar(onDismiss: onDismiss))
    }
}
