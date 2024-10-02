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
        await withKnownIssue {
            try await GetWords(word: "look").request()
        }
    }
}
