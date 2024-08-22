//
//  ReceiveTimer.swift
//  Define
//
//  Created by Ben Shutt on 24/10/2023.
//

import SwiftUI
import Combine

private struct ReceiveTimer: ViewModifier {
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    var runTask: Bool
    var onReceive: () async -> Void

    init(
        timeInterval: TimeInterval,
        runTask: Bool,
        onReceive: @escaping () async -> Void
    ) {
        timer = Timer.publish(
            every: timeInterval,
            tolerance: 0.5, // For timer coalescing
            on: .main,
            in: .common
        )
        .autoconnect()

        self.runTask = runTask
        self.onReceive = onReceive
    }

    func body(content: Content) -> some View {
        content
            .task {
                if runTask {
                    await onReceive()
                }
            }
            .onReceive(timer) { _ in
                Task {
                    await onReceive()
                }
            }
    }
}

// MARK: - View + Extensions

extension View {
    func onReceiveTimer(
        timeInterval: TimeInterval,
        runTask: Bool = false,
        onReceive: @escaping () async -> Void
    ) -> some View {
        modifier(ReceiveTimer(
            timeInterval: timeInterval,
            runTask: runTask,
            onReceive: onReceive
        ))
    }
}
