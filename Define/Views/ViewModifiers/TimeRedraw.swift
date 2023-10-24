//
//  TimeRedraw.swift
//  Define
//
//  Created by Ben Shutt on 24/10/2023.
//

import SwiftUI

struct TimeRedraw: ViewModifier {

    @State private var id = UUID()
    @State private var timer: Timer?
    var timeInterval: TimeInterval = 60
    var onRedraw: () -> Void = {}

    private func redraw() {
        onRedraw()
        id = UUID()
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
                redraw()
                timer?.invalidate()
                timer = Timer.scheduledTimer(
                    withTimeInterval: timeInterval,
                    repeats: true
                ) { _ in
                    redraw()
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
    }
}
