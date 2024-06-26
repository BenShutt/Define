//
//  View+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 26/06/2024.
//

import SwiftUI

extension View {
    func button(action: @escaping () -> Void) -> some View {
        Button(action: action, label: { self })
    }
}
