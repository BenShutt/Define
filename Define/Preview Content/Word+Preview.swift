//
//  Word+Preview.swift
//  Define
//
//  Created by Ben Shutt on 16/10/2022.
//

import Foundation
import DictionaryAPI
import CubeFoundation

extension Word {

    /// Preview content for `Word`
    static var preview: Word {
        do {
            return try loadFromFile()
        } catch {
            fatalError("\(Word.self) used for preview threw an error")
        }
    }

    /// Load `Word` from file
    private static func loadFromFile() throws -> Word {
        let resourceURL = Bundle.main.url(forResource: "hello", withExtension: "json")
        let url = try resourceURL ?! WordPreviewError.resourceURL
        let data = try Data(contentsOf: url)
        let words = try JSONDecoder().decode([Word].self, from: data)
        return try words.first ?! WordPreviewError.first
    }
}

// MARK: - WordPreviewError

enum WordPreviewError: Error {
    case resourceURL
    case first
}
