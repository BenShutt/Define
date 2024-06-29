//
//  SegmentedControl.swift
//  Define
//
//  Created by Ben Shutt on 29/06/2024.
//

import SwiftUI

struct SegmentedControl: View {
    @Binding var selectedIndex: Int
    var titles: [LocalizedStringKey]

    var body: some View {
        HStack(spacing: .medium) {
            ForEach(titles.zipped, id: \.index) { index, title in
                Button(action: {
                    withAnimation {
                        selectedIndex = index
                    }
                }, label: {
                    SegmentView(
                        selectedIndex: $selectedIndex,
                        index: index,
                        title: title
                    )
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.margins)
        .background(Color.appLightGray)
    }
}

// MARK: - SegmentView

private struct SegmentView: View {
    @Binding var selectedIndex: Int
    var index: Int
    var title: LocalizedStringKey

    private func textColor(for index: Int) -> Color {
        index == selectedIndex ? .appWhite : .appGray
    }

    var body: some View {
        Text(title)
            .textStyle(
                .tag,
                lineLimit: 1,
                textColor: textColor(for: index)
            )
            .padding(.vertical, .smallMedium)
            .padding(.horizontal, .large)
            .background {
                if index == selectedIndex {
                    Color.appBlue
                        .clipShape(Capsule())
                        .transition(.opacity)
                }
            }
    }
}

// MARK: - Preview

private struct PreviewView: View {
    @State private var selectedIndex = 0

    var body: some View {
        SegmentedControl(selectedIndex: $selectedIndex, titles: [
            "home_segment_title",
            "info_segment_title"
        ])
    }
}

#Preview {
    VStack {
        PreviewView()
        Spacer()
    }
}
