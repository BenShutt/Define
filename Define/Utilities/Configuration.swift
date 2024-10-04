//
//  Configuration.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2024.
//

import Foundation
import Utilities

// TODO: Remove @preconcurrency https://github.com/stripe/stripe-ios/issues/3509
@preconcurrency import StripePayments

let appName = Configuration.bundleDisplayName

struct Configuration {
    static let bundleIdentifier: String = value(forKey: "BUNDLE_IDENTIFIER")
    static let merchantIdentifier: String = value(forKey: "MERCHANT_IDENTIFIER")
    static let bundleDisplayName: String = value(forKey: "BUNDLE_DISPLAY_NAME")
    static let stripePublishableKey: String = value(forKey: "STRIPE_PUBLISHABLE_KEY")

    static func setup() {
        StripeAPI.defaultPublishableKey = stripePublishableKey
    }

    private static func value<Value>(forKey key: String) -> Value {
        guard let value: Value = Bundle.main.value(forKey: key) else {
            fatalError("\(Self.self) value nil for key '\(key)'")
        }
        return value
    }
}
