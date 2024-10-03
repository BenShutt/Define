//
//  ApplePayButton.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2024.
//

import SwiftUI
import PassKit

// TODO: Prerequisites for Apple Pay
// 1. Make merchant identifier in Apple Developer portal (merchant.{bundleId})
// 2. Add this merchant identifier in the signing and capabilities tab in Xcode
struct ApplePay {

    /// Identifier of the merchant set up in capabilities and the developer portal
    var merchantIdentifier: String {
        if let bundleId = Bundle.main.bundleIdentifier {
            "merchant.\(bundleId)"
        } else {
            fatalError("Nil Bundle ID")
        }
    }

    /// Two-letter ISO 3166 country code.
    /// Set to code for: "United Kingdom of Great Britain and Northern Ireland"
    let countryCode = "GB"

    /// Three-letter ISO 4217 currency code.
    /// Set to code for: "United Kingdom of Great Britain and Northern Ireland"
    let currencyCode = "GBP"

    /// Payment-processing protocols and card types that are supported
    let capabilities: PKMerchantCapability = .threeDSecure

    /// Payment methods that the user can select to fund the payment
    let networks: [PKPaymentNetwork] = [
        .amex,
        .discover,
        .masterCard,
        .visa
    ]

    func canRequest() -> Bool {
        PKPaymentAuthorizationController.canMakePayments()
    }

    func request(amount: Decimal) -> PKPaymentRequest {
        let request = PKPaymentRequest()

        request.merchantIdentifier = merchantIdentifier
        request.merchantCapabilities = capabilities

        request.countryCode = countryCode
        request.currencyCode = currencyCode

        request.supportedNetworks = networks
        request.paymentSummaryItems = [
            .init(
                label: .init(localized: "apple_payment_title"),
                amount: .init(decimal: amount),
                type: .final // TODO: Total?
            )
        ]

        return request
    }

    func canSetupCards() -> Bool {
        PKPaymentAuthorizationController.canMakePayments(
            usingNetworks: networks,
            capabilities: capabilities
        )
    }

    func setupCards() {
        PKPassLibrary().openPaymentSetup()
    }
}

// MARK: - ApplePayButton

struct ApplePayButton: View {
    private let applePay = ApplePay()
    var amount: Decimal

    private func onPaymentAuthorizationChange(
        phase: PayWithApplePayButtonPaymentAuthorizationPhase
    ) {
        switch phase {
        case .willAuthorize:
            break

        case let .didAuthorize(_, resultHandler):
            // Check country code?
            let result = PKPaymentAuthorizationResult(status: .success, errors: nil)
            resultHandler(result)

        case .didFinish:
            break

        @unknown default:
            break
        }
    }

    var body: some View {
        Group {
            if applePay.canRequest() {
                PayWithApplePayButton(
                    .donate,
                    request: applePay.request(amount: amount),
                    onPaymentAuthorizationChange: onPaymentAuthorizationChange
                )
            } else if applePay.canSetupCards() {
                PayWithApplePayButton(.setUp) {
                    applePay.setupCards()
                }
            }
        }
        .payWithApplePayButtonStyle(.black)
    }
}
