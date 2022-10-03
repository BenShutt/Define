//
//  Debug.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import Foundation

/// Debug environment configuration
struct Debug {

    /// Returns `true` if the `DEBUG` preprocessor macro is defined
    static var isDebugging: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
