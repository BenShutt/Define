//
//  ValidatedTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 09/10/2023.
//

import XCTest
import DictionaryAPI

final class ValidatedTests: XCTestCase {

    func test() throws {
        var elements = ["zero", " one", " two ", " three \n"]
        try elements.validate()
        XCTAssertEqual(
            elements,
            ["zero", "one", "two", "three"]
        )
    }

    func testThrows() {
        var elements = ["valid", " "]
        XCTAssertThrowsError(try elements.validate())
    }
}
