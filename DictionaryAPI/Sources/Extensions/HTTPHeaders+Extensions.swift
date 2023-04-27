//
//  HTTPHeaders+Extensions.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 17/12/2022.
//

import Alamofire

extension HTTPHeaders {

    /// Append a `header`
    /// - Parameter header: `HTTPHeader`
    mutating func append(_ header: HTTPHeader) {
        self = appending(header)
    }

    /// Append `headers`
    /// - Parameter headers: The headers
    /// - Returns: HTTPHeaders
    func appending(_ headers: HTTPHeader...) -> HTTPHeaders {
        appending(HTTPHeaders(headers))
    }

    /// Append `headers`
    /// - Parameter headers: `HTTPHeaders`
    /// - Returns: `HTTPHeaders`
    func appending(_ headers: HTTPHeaders) -> HTTPHeaders {
        var allHeaders = self
        headers.forEach {
            allHeaders.add($0)
        }
        return allHeaders
    }
}

// MARK: HTTPHeader + Extensions

extension HTTPHeader {

    /// `"Accept: application/json"`
    static let acceptJSON = HTTPHeader(
        name: "Accept",
        value: "application/json"
    )

    /// `"Content-Type: application/json"`
    static let contentTypeJSON: HTTPHeader = .contentType("application/json")
}
