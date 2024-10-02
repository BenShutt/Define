//
//  GetWordsTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 27/04/2023.
//

import Testing
import Alamofire
import DictionaryAPI

@Suite struct GetWordsTests {
    @Test func hello() async throws {
        let words = try await GetWords(word: "hello").request()
        #expect(!words.isEmpty)
    }

    @Test func look() async throws {
        do {
            // The API seems to be missing "look"?
            _ = try await GetWords(word: "look").request()
            #expect(Bool(false))
        } catch {
            #expect(error.responseCode == 404)
        }
    }
}

// MARK: - Error + Alamofire

private extension Error {
    var responseCode: Int? {
        (self as? AFError)?.responseCode
    }
}
