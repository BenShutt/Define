//
//  GetWordsTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 27/04/2023.
//

import XCTest
import Alamofire
import DictionaryAPI

final class GetWordsTests: XCTestCase {
    func testSuccess() async throws {
        let words = try await GetWords(word: "hello").requestAndValidate()
        XCTAssertFalse(words.isEmpty)
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

// MARK: - Error + Alamofire

private extension Error {
    var responseCode: Int? {
        (self as? AFError)?.responseCode
    }
}
