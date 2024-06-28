//
//  PreviewColorView.swift
//  Define
//
//  Created by Ben Shutt on 27/06/2024.
//

import SwiftUI

// MARK: - PreviewColorView

struct PreviewColorView: View {
    var index: Int
    var color: Color
    var height: CGFloat = 200

    private var padding: CGFloat {
        height / 20
    }

    private var shape: RoundedRectangle {
        .init(cornerRadius: height / 10)
    }

    var body: some View {
        color
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .clipShape(shape)
            .padding(padding)
            .overlay {
                Text(index, format: .number)
                    .textStyle(.h1, textColor: .appDarkGray)
                    .padding(padding)
                    .background(Color.appLightGray)
                    .clipShape(shape)
            }
    }
}

// MARK: - PreviewColorList

struct PreviewColorList<Content: View>: View {
    var nItems = 20
    @ViewBuilder var content: (Int, Color) -> Content

    private var colors: [Color] {
        (1...nItems).map { _ in .random() }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(colors.zipped, id: \.0) { index, color in
                    content(index, color)
                }
            }
        }
    }
}
