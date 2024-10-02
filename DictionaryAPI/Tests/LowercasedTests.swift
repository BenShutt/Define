//
//  LowercasedTests.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 12/09/2024.
//

import Testing
import Foundation
import DictionaryAPI

@Suite struct LowercasedTests {
    private struct Model: Decodable {
        @Trimmed @Lowercased var one: String
        @Lowercased var two: String
    }

    // MARK: - Tests

    @Test func lowercase() throws {
        let model = Model(one: "One", two: "TWO")
        #expect(model.one == "one")
        #expect(model.two == "two")
    }

    @Test func lowercaseTrimmed() throws {
        let model = Model(one: " OnE ", two: " tWo ")
        #expect(model.one == "one")
        #expect(model.two == " two ")
    }

    @Test func decode() throws {
        let json = "{\"one\":\" ONE \",\"two\":\" TWO \"}"
        let jsonData = Data(json.utf8)
        let model = try JSONDecoder().decode(Model.self, from: jsonData)
        #expect(model.one == "one")
        #expect(model.two == " two ")
    }
}
