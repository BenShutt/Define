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
private struct ApplePay {

    /// Identifier of the merchant set up in capabilities and the developer portal
    private var merchantIdentifier: String {
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        return "merchant.\(bundleId)"
    }

    /// Two-letter ISO 3166 country code.
    /// Set to code for: "United Kingdom of Great Britain and Northern Ireland"
    private let countryCode = "GB"

    /// Three-letter ISO 4217 currency code.
    /// Set to code for: "United Kingdom of Great Britain and Northern Ireland"
    private let currencyCode = "GBP"

    /// Payment-processing protocols and card types that are supported
    private let capabilities: PKMerchantCapability = .threeDSecure

    /// Payment methods that the user can select to fund the payment
    private let networks: [PKPaymentNetwork] = [
        .amex,
        .discover,
        .masterCard,
        .visa
    ]

    func canMakePayments() -> Bool {
        PKPaymentAuthorizationController.canMakePayments()
    }

    func canSetupCards() -> Bool {
        PKPaymentAuthorizationController.canMakePayments(
            usingNetworks: networks,
            capabilities: capabilities
        )
    }

    func request(amount: Decimal) -> PKPaymentRequest {
        let request = PKPaymentRequest()

        request.merchantIdentifier = merchantIdentifier
        request.merchantCapabilities = capabilities

        request.countryCode = countryCode
        request.currencyCode = currencyCode

        request.supportedNetworks = networks
        request.paymentSummaryItems = [.init(
            label: .init(localized: "apple_payment_title"),
            amount: .init(decimal: amount),
            type: .final // TODO: Total?
        )]

        return request
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

        case let .didAuthorize(payment, resultHandler):
            let result = PKPaymentAuthorizationResult(status: .success, errors: nil)
            resultHandler(result)

        case .didFinish:
            break

        @unknown default:
            break
        }
    }

    private func button(_ label: PayWithApplePayButtonLabel) -> some View {
        PayWithApplePayButton(
            label,
            request: applePay.request(amount: amount),
            onPaymentAuthorizationChange: onPaymentAuthorizationChange
        )
        .payWithApplePayButtonStyle(.black)
    }

    var body: some View {
        if applePay.canMakePayments() {
            button(.donate)
        } else if applePay.canSetupCards() {
            button(.setUp)
        }
    }
}
