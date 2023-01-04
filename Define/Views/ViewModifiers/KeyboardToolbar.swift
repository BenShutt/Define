//
//  KeyboardToolbar.swift
//  Define
//
//  Created by Ben Shutt on 18/12/2022.
//

import SwiftUI

/// `Binding` to a `FocusState` with a `Bool`
typealias FocusStateBinding = FocusState<Bool>.Binding

/// Add toolbar for keyboard
struct KeyboardToolbar: ViewModifier {

    /// Focus state of field
    var isFocused: FocusStateBinding

    /// Apply overlay of stroked `RoundedRectangle`
    ///
    /// - Parameter content: `Content`
    /// - Returns: `View`
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(String.Misc.dismiss) {
                    isFocused.wrappedValue = false
                }
            }
        }
    }
}

// MARK: View + KeyboardToolbar

extension View {

    /// Add `KeyboardToolbar` modifier
    /// - Parameter isFocused: `FocusStateBinding`
    /// - Returns: `View`
    func keyboardToolbar(isFocused: FocusStateBinding) -> some View {
        modifier(KeyboardToolbar(isFocused: isFocused))
    }
}
