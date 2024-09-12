//
//  TrimmedTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 09/10/2023.
//

import XCTest
import DictionaryAPI

final class TrimmedTests: XCTestCase {

    // MARK: - Models

    private struct StringKey: Decodable {
        @Trimmed var key: String
    }

    private struct OptionalStringKey: Decodable {
        @Trimmed var key: String?
    }

    // MARK: - Tests

    func testValid() throws {
        try testStringKey(json("X"), expectedValue: "X")
    }

    func testInvalid() throws {
        let never = UUID().uuidString
        XCTAssertThrowsError(try testStringKey("{}", expectedValue: never))
        XCTAssertThrowsError(try testStringKey(nullJSON(), expectedValue: never))
        XCTAssertThrowsError(try testStringKey(json(""), expectedValue: never))
        XCTAssertThrowsError(try testStringKey(json(" "), expectedValue: never))
    }

    func testOptionalValid() throws {
        try testOptionalStringKey("{}", expectedValue: nil)
        try testOptionalStringKey(nullJSON(), expectedValue: nil)
    }

    func testOptionalInvalid() throws {
        let never = UUID().uuidString
        XCTAssertThrowsError(try testOptionalStringKey(json(""), expectedValue: never))
        XCTAssertThrowsError(try testOptionalStringKey(json(" "), expectedValue: never))
    }

    func testSpaces() throws {
        try testStringKey(json(" X"), expectedValue: "X")
        try testStringKey(json("X "), expectedValue: "X")
        try testStringKey(json(" X "), expectedValue: "X")
    }

    func testNewLines() throws {
        try testStringKey(json("\\nX"), expectedValue: "X")
        try testStringKey(json("X\\n"), expectedValue: "X")
        try testStringKey(json("\\nX\\n"), expectedValue: "X")
    }

    func testSpacesAndNewLines() throws {
        try testStringKey(json("\\n X \\n"), expectedValue: "X")
    }

    // MARK: - Helper

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
        XCTAssertEqual(model.key, expectedValue)
        try testOptionalStringKey(json, expectedValue: expectedValue)
    }

    private func testOptionalStringKey(
        _ json: String,
        expectedValue: String?
    ) throws {
        let model = try decode(json, as: OptionalStringKey.self)
        XCTAssertEqual(model.key, expectedValue)
    }

    // MARK: - JSON

    private func json(_ value: String) -> String {
        "{\"key\":\"\(value)\"}"
    }

    private func nullJSON() -> String {
        "{\"key\":null}"
    }
}
