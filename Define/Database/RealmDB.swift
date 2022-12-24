//
//  RealmDB.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation
import RealmSwift

/// Wrapper of a `Realm` database.
///
/// # Threading
/// Instances of `Realm`, `Results`, `List`, and managed `Objects` are thread-confined.
/// That means you may only use them on the thread where you created them.
/// https://www.mongodb.com/docs/realm/sdk/swift/advanced-guides/threading/
///
/// # Documentation
/// https://www.mongodb.com/docs/realm/sdk/swift/
struct RealmDB {

    /// A batch of work to run on the `Realm`
    typealias Operation = (Realm) throws -> Void

    /// `Result` from `Operation`
    typealias OperationResult = Result<Void, Error>

    /// Completion handler
    typealias Completion = (OperationResult) -> Void

    /// Make model closure
    ///
    /// - Note:
    /// Using a closure to make a `Model` allows us to create `Object` instances in
    /// a desired thread. It saves the trouble of using, say, `ThreadSafeReference`
    /// and `autoreleasepool`s just to pass a model to another thread.
    typealias Make<Model> = () -> Model

    /// Serial background queue to run Realm operations
    static let dbQueue = DispatchQueue(label: "com.define.realm")

    /// Get the `Realm.Configuration`
    /// - Returns: `Realm.Configuration`
    private static func configuration() throws -> Realm.Configuration {
        Realm.Configuration(
            schemaVersion: 0, // Increment for each migration
            migrationBlock: { migration, oldSchemaVersion in
                handleRealmMigration(migration, oldSchemaVersion)
            }
        )
    }

    /// Get a `Realm` instance
    /// - Returns: `Realm`
    static func realm() throws -> Realm {
        try Realm(configuration: configuration())
    }

    /// Async operation
    ///
    /// - Parameters:
    ///   - object: `Object`
    ///   - operation: `Operation` to execute
    ///   - completion: `Completion` called on the main thread
    static func async(
        operation: @escaping Operation,
        completion: Completion? = nil
    ) {
        // Get the configuration on main
        let configurationResult = Result(catching: { try Self.configuration() })
        dbQueue.async {
            let result: OperationResult

            do {
                let configuration = try configurationResult.get()
                let realm = try Realm(configuration: configuration)
                try operation(realm)
                result = .success(())
            } catch {
                result = .failure(error)
            }

            guard let completion = completion else { return }
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }

    // MARK: - CRUD

    /// Insert `model` into the Realm database
    ///
    /// - Parameters:
    ///   - model: `Make<Model>`
    ///   - completion: `Completion`
    static func insert<Model: Object>(
        _ make: @escaping Make<[Model]>,
        completion: Completion? = nil
    ) {
        RealmDB.async(operation: { realm in
            try realm.write {
                realm.add(make())
            }
        }, completion: completion)
    }

    // MARK: - Migrations

    /// Handle a Realm db migration
    ///
    /// - Parameters:
    ///   - migration: `Migration`
    ///   - oldSchemaVersion: `UInt64`
    private static func handleRealmMigration(
        _ migration: Migration,
        _ oldSchemaVersion: UInt64
    ) {
        // Do nothing, can handle in a later release
    }
}
