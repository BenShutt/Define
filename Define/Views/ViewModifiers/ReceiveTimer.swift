//
//  ReceiveTimer.swift
//  Define
//
//  Created by Ben Shutt on 24/10/2023.
//

import SwiftUI
import Combine

struct ReceiveTimer: ViewModifier {

    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    var onReceive: () -> Void

    init(
        timeInterval: TimeInterval,
        onReceive: @escaping () -> Void
    ) {
        timer = Timer.publish(every: timeInterval).autoconnect()
        self.onReceive = onReceive
    }

    func body(content: Content) -> some View {
        content
            .onReceive(timer) { _ in
                onReceive()
            }
            .onAppear {
                onReceive()
            }
    }
}

// MARK: - View + Extensions

extension View {

    func onReceiveTimer(
        timeInterval: TimeInterval = 60,
        onReceive: @escaping () -> Void
    ) -> some View {
        modifier(ReceiveTimer(
            timeInterval: timeInterval,
            onReceive: onReceive
        ))
    }
}

// MARK: - Timer + Extensions

private extension Timer {

    static func publish(every timeInterval: TimeInterval) -> TimerPublisher {
        publish(
            every: timeInterval,
            tolerance: 0.5, // For timer coalescing
            on: .main,
            in: .common
        )
    }
}
