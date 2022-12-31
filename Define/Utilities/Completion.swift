//
//  Completion.swift
//  Define
//
//  Created by Ben Shutt on 31/12/2022.
//

import Foundation
import DictionaryAPI

// TODO: Surely can simplify/re-work
struct Completion {

    /// Run asynchronous functionality on detatched `Task` and complete on main
    /// - Parameters:
    ///   - operation: Asynchronous functionality
    ///   - completion: Completion handler that runs on main
    static func run<T>(
        operation: @escaping () async throws -> T,
        completion: @escaping (ModelResult<T>) -> Void
    ) {
        Task.detached(priority: .high) {
            let result: ModelResult<T>
            do {
                result = try await .success(operation())
            } catch {
                result = .failure(error)
            }

            await MainActor.run {
                completion(result)
            }
        }
    }
}
