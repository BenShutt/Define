//
//  String+Contants.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation

extension String {

    /// Language to get entries for
    static var language: String {
        "en-gb"
    }

    /// Dictionary API app identifier
    struct AppId {

        /// Header name
        static var name: String {
            "app_id"
        }

        /// Header value
        static var value: String {
            "da68be2f"
        }
    }

    /// Dictionary API app key
    struct AppKey {

        /// Header name
        static var name: String {
            "app_key"
        }

        /// Header value
        static var value: String {
            DictionaryAPIKey.apiKey
        }
    }
}
