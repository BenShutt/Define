//
//  StyledText.swift
//  Define
//
//  Created by Ben Shutt on 25/06/2024.
//

import SwiftUI

struct StyledText: ViewModifier {
    var font: WorkSans
    var fontSize: CGFloat
    var truncationMode: Text.TruncationMode = .tail
    var lintLimit: Int?
    var foregroundColor: Color
    var maxWidth: CGFloat?
    var textAlignment: TextAlignment = .center

    var alignment: Alignment {
        switch textAlignment {
        case .leading: .leading
        case .center: .center
        case .trailing: .trailing
        }
    }

    func body(content: Content) -> some View {
        content
            .workSans(font, size: fontSize)
            .truncationMode(.tail)
            .lineLimit(lintLimit)
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: maxWidth, alignment: alignment)
            .multilineTextAlignment(textAlignment)
    }
}
