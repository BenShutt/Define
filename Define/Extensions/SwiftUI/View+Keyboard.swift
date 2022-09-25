//
//  View+Keyboard.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import SwiftUI

#if canImport(UIKit)
extension View {

    /// Hide the keyboard by resigning the first responder on the `UIApplication`
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
#endif
