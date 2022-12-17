//
//  HTTPHeader+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import Foundation
import Alamofire

extension HTTPHeader {

    static var appId: HTTPHeader {
        .init(name: .appIdHeaderName, value: DictionaryAPIKey.apiKey?.appId ?? "")
    }

    static var appKey: HTTPHeader {
        .init(name: .appKeyHeaderName, value: DictionaryAPIKey.apiKey?.appKey ?? "")
    }
}
