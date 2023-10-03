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
        _ = try await GetWords(word: "hello").request()
    }

    func testFailure() async throws {
        do {
            _ = try await GetWords(word: "look").request() // Missing "look"?
        } catch {
            XCTAssertEqual(error.responseCode, 404)
        }
    }
}
