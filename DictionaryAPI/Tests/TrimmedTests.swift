//
//  TrimmedTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 09/10/2023.
//

import Foundation
import Testing
import DictionaryAPI

@Suite struct TrimmedTests {
    let uuid = UUID().uuidString

    // MARK: - Models

    private struct StringKey: Decodable {
        @Trimmed var key: String
    }

    private struct OptionalStringKey: Decodable {
        @Trimmed var key: String?
    }

    // MARK: - Tests

    @Test func valid() throws {
        try testStringKey(json("X"), expectedValue: "X")
    }

    @Test func invalid() throws {
        expectThrows(try testStringKey("{}", expectedValue: uuid))
        expectThrows(try testStringKey(nullJSON(), expectedValue: uuid))
        expectThrows(try testStringKey(json(""), expectedValue: uuid))
        expectThrows(try testStringKey(json(" "), expectedValue: uuid))
    }

    @Test func optionalValid() throws {
        try testOptionalStringKey("{}", expectedValue: nil)
        try testOptionalStringKey(nullJSON(), expectedValue: nil)
    }

    @Test func optionalInvalid() throws {
        expectThrows(try testOptionalStringKey(json(""), expectedValue: uuid))
        expectThrows(try testOptionalStringKey(json(" "), expectedValue: uuid))
    }

    @Test func spaces() throws {
        try testStringKey(json(" X"), expectedValue: "X")
        try testStringKey(json("X "), expectedValue: "X")
        try testStringKey(json(" X "), expectedValue: "X")
    }

    @Test func newLines() throws {
        try testStringKey(json("\\nX"), expectedValue: "X")
        try testStringKey(json("X\\n"), expectedValue: "X")
        try testStringKey(json("\\nX\\n"), expectedValue: "X")
    }

    @Test func spacesAndNewLines() throws {
        try testStringKey(json("\\n X \\n"), expectedValue: "X")
    }

    // MARK: - Helper

    /// Check if a function throws _any_ error.
    /// This is used when we are not concerned with the specific error that is thrown
    private func expectThrows(_ closure: @autoclosure () throws -> Void) {
        do {
            try closure()
            #expect(Bool(false))
        } catch {
            // Do nothing
        }
    }

    private func decode<Model: Decodable>(
        _ json: String,
        as modelType: Model.Type
    ) throws -> Model {
        try JSONDecoder().decode(modelType, from: .init(json.utf8))
    }

    private func testStringKey(
        _ json: String,
        expectedValue: String
    ) throws {
        let model = try decode(json, as: StringKey.self)
        #expect(model.key == expectedValue)
        try testOptionalStringKey(json, expectedValue: expectedValue)
    }

    private func testOptionalStringKey(
        _ json: String,
        expectedValue: String?
    ) throws {
        let model = try decode(json, as: OptionalStringKey.self)
        #expect(model.key == expectedValue)
    }

    // MARK: - JSON

    private func json(_ value: String) -> String {
        "{\"key\":\"\(value)\"}"
    }

    private func nullJSON() -> String {
        "{\"key\":null}"
    }
}
