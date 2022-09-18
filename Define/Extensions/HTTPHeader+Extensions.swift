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
        .init(name: .AppId.name, value: .AppId.value)
    }

    static var appKey: HTTPHeader {
        .init(name: .AppKey.name, value: .AppKey.value)
    }
}
