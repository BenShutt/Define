//
//  LocalizationTests.swift
//  DefineTests
//
//  Created by Ben Shutt on 06/10/2023.
//

import XCTest
@testable import Define

// TODO: Run tests on simulator

/// Test `Localization`
class LocalizationTests: XCTestCase {

    func testExpressibleByStringInterpolation() {
        let int = 123
        let string = "argument"
        let localization: Localization = "my_key \(int) \(string)"

        XCTAssertEqual(localization.key, "my_key %lld %@")
        XCTAssertEqual(localization.arguments.count, 2)
        XCTAssertEqual(localization.arguments[0] as? Int, int)
        XCTAssertEqual(localization.arguments[1] as? String, string)
    }
}
