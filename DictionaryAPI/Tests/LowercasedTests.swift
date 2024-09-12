//
//  LowercasedTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 12/09/2024.
//

import XCTest
import DictionaryAPI

final class LowercasedTests: XCTestCase {
    private struct Model: Decodable {
        @Trimmed @Lowercased var one: String
        @Lowercased var two: String
    }

    // MARK: - Tests

    func testLowercase() throws {
        let model = Model(one: "One", two: "TWO")
        XCTAssertEqual(model.one, "one")
        XCTAssertEqual(model.two, "two")
    }

    func testLowercaseTrimmed() throws {
        let model = Model(one: " OnE ", two: " tWo ")
        XCTAssertEqual(model.one, "one")
        XCTAssertEqual(model.two, " two ")
    }

    func testDecode() throws {
        let json = "{\"one\":\" ONE \",\"two\":\" TWO \"}"
        let jsonData = Data(json.utf8)
        let model = try JSONDecoder().decode(Model.self, from: jsonData)
        XCTAssertEqual(model.one, "one")
        XCTAssertEqual(model.two, " two ")
    }
}
