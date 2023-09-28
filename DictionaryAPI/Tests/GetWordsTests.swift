//
//  GetWordsTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 27/04/2023.
//

import XCTest
import DictionaryAPI

final class GetWordsTests: XCTestCase {

    func test() async throws {
        print("extraBoldItalic".uppercasedFirstCharacter)
        _ = try await GetWords(word: "hello").request()
    }
}
