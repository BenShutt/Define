//
//  StringTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 03/10/2023.
//

import XCTest
import DictionaryAPI

final class StringTests: XCTestCase {

    func test() async throws {
        XCTAssertEqual(
            "extraBoldItalic".uppercasedFirstCharacter,
            "ExtraBoldItalic"
        )
    }
}
