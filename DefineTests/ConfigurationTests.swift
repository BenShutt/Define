//
//  ConfigurationTests.swift
//  DefineTests
//
//  Created by Ben Shutt on 04/10/2024.
//

import Testing
@testable import Define

@Suite struct ConfigurationTests {
    @Test func all() {
        _ = Configuration.bundleIdentifier
        _ = Configuration.merchantIdentifier
        _ = Configuration.bundleDisplayName
        _ = Configuration.stripePublishableKey
    }
}
