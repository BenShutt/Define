//
//  Error+Alamofire.swift
//  DictionaryAPI
//
//  Created by Ben Shutt on 03/10/2023.
//

import Foundation
import Alamofire

extension Error {

    var responseCode: Int? {
        (self as? AFError)?.responseCode
    }
}
