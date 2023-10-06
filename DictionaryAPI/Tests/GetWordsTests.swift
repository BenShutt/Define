//
//  GetWordsTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 27/04/2023.
//

import XCTest
import DictionaryAPI

final class GetWordsTests: XCTestCase {

    func testSuccess() async throws {
        _ = try await GetWords(word: "hello").requestAndValidate()
    }

    func testFailure() async throws {
        do {
            // The API seems to be missing "look"?
            _ = try await GetWords(word: "look").requestAndValidate()
        } catch {
            XCTAssertEqual(error.responseCode, 404)
        }
    }
}
