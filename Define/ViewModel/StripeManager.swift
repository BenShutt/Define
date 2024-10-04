//
//  Stripe.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2024.
//

import Foundation
import Alamofire
import StripePaymentSheet

@MainActor
final class StripeManager: ObservableObject {
    private struct RequestBody: Codable {
        var amount: Int
    }

    private struct ResponseBody: Codable {
        var clientSecret: String
    }

    @Published var isPresentingSheet = false
    @Published private(set) var paymentSheet = makePaymentSheet(clientSecret: "")
    @Published private(set) var isLoading = false
    private let url = "http://127.0.0.1:4242/create-payment-intent"

    private static func makePaymentSheet(clientSecret: String) -> PaymentSheet {
        var configuration = PaymentSheet.Configuration()
        configuration.applePay = nil
        configuration.merchantDisplayName = appName
        return PaymentSheet(
            paymentIntentClientSecret: clientSecret,
            configuration: configuration
        )
    }

    func process(amount: GBP) {
        Task {
            do {
                try await process(amount: amount)
            } catch {
                log(error: error)
            }
        }
    }

    private func process(amount: GBP) async throws {
        isLoading = true
        defer { isLoading = false }

        let response = try await request(amount: amount)
        paymentSheet = Self.makePaymentSheet(clientSecret: response.clientSecret)
        isPresentingSheet = true // Stripe only have Bool bindings
    }

    private nonisolated func request(amount: GBP) async throws -> ResponseBody {
        let value = (amount as NSDecimalNumber).intValue
        let model = RequestBody(amount: value)

        var headers: HTTPHeaders = .default
        headers.add(.contentTypeJSON)
        var request = try URLRequest(
            url: url,
            method: .post,
            headers: headers
        )
        request.httpBody = try JSONEncoder().encode(model)

        return try await AF.request(request)
            .validate()
            .serializingDecodable(ResponseBody.self)
            .value
    }
}
