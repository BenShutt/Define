//
//  SegmentedControl.swift
//  Define
//
//  Created by Ben Shutt on 29/06/2024.
//

import SwiftUI

protocol SegmentedItem: Identifiable, Equatable {
    var title: LocalizedStringKey { get }
}

struct SegmentedControl<Segment: SegmentedItem>: View {
    @Binding var selectedSegment: Segment
    var segments: [Segment]

    var body: some View {
        HStack(spacing: .medium) {
            ForEach(segments) { segment in
                Button(action: {
                    withAnimation {
                        selectedSegment = segment
                    }
                }, label: {
                    SegmentView(
                        selectedSegment: $selectedSegment,
                        segment: segment
                    )
                })
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - SegmentView

private struct SegmentView<Segment: SegmentedItem>: View {
    @Binding var selectedSegment: Segment
    var segment: Segment

    private var isSelected: Bool {
        segment == selectedSegment
    }

    var body: some View {
        Text(segment.title)
            .textStyle(
                .tag,
                lineLimit: 1,
                textColor: isSelected ? .appDarkGray : .appGray
            )
            .frame(maxWidth: .infinity)
            .padding(.vertical, .smallMedium)
            .padding(.horizontal, .large)
            .background {
                if isSelected {
                    Color.appWhite
                        .clipShape(Capsule())
                }
            }
    }
}

// MARK: - Preview

private struct PreviewView: View {
    @State private var selectedSegment: RootSegment = .home

    var body: some View {
        SegmentedControl(
            selectedSegment: $selectedSegment,
            segments: RootSegment.allCases
        )
        .padding(.margins)
    }
}

#Preview {
    VStack {
        PreviewView()
        Spacer()
    }
}
