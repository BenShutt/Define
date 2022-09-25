//
//  Publisher+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 25/09/2022.
//

import Foundation
import Combine

extension Publisher where Failure == Never {

    /// Common observer combine instructions
    ///
    /// - Parameters:
    ///   - queue: `DispatchQueue`
    ///   - set: `DispatchQueue`
    ///   - sink: On receive closure
    func sinkAndStore(
        on queue: DispatchQueue = .main,
        in set: inout Set<AnyCancellable>,
        sink: @escaping (Output) -> Void
    ) {
        self
            .receive(on: queue)
            .sink(receiveValue: sink)
            .store(in: &set)
    }
}
