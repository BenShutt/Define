//
//  RequestBody.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 06/02/2023.
//

import Foundation
import Alamofire

/// An entity that can that a HTTP request body
protocol RequestBody {

    /// `HTTPHeader` for the body content type
    var contentType: HTTPHeader { get }

    /// Request body data
    var body: Data { get throws }
}
