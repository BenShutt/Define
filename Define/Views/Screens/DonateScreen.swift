//
//  DonateScreen.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2024.
//

import SwiftUI

// MARK: - Amount

struct Amount {
    let currencyCode = ApplePay().currencyCode
    let min: GBP = 1
    let isQuick: Bool
    let amount: GBP

    var isValid: Bool {
        amount >= min
    }

    var color: Color {
        isValid ? .appGreen : .appRed
    }

    func formatted(amount: GBP) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        return formatter.string(from: NSDecimalNumber(decimal: amount))
    }

    var title: LocalizedStringKey {
        if isValid, let formattedAmount = formatted(amount: amount) {
            "amount_valid \(formattedAmount)"
        } else {
            // Note: hardcoded currency in localized value
            "amount_invalid"
        }
    }

    init(quick amount: GBP) {
        isQuick = true
        self.amount = amount.rounded(scale: 2)
    }

    init(other amount: GBP) {
        isQuick = false
        self.amount = amount.rounded(scale: 2)
    }
}

// MARK: - DonateScreen

struct DonateScreen: View {
    @Environment(\.push) private var push
    @State private var selectedAmount: Amount
    private let quickAmounts: [GBP] = [5, 10, 20]

    init() {
        guard let first = quickAmounts.first else { fatalError("quickAmounts") }
        _selectedAmount = .init(wrappedValue: .init(quick: first))
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("donate_body")
                .textStyle(.body, fill: .leading)

            HStack(spacing: .medium) {
                ForEach(quickAmounts, id: \.self) { amount in
                    QuickAmountButton(
                        selectedAmount: $selectedAmount,
                        amount: amount
                    )
                }
            }
            .padding(.top, .large)

            OtherAmountButton(selectedAmount: $selectedAmount)
                .padding(.top, .medium)

            Text(selectedAmount.title)
                .foregroundStyle(selectedAmount.color)
                .textStyle(.h4)
                .padding(.top, .medium)

            Spacer(minLength: 0)
        }
        .padding(.margins)
        .screen()
        .stickyBottom {
            ApplePayButton(
                amount: selectedAmount.amount,
                onFinish: {
                    push(.thankYou)
                }
            )
            .buttonEnabled(selectedAmount.isValid)
            .frame(maxWidth: .infinity, minHeight: 50)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.margins)
        }
        .navigationBar(title: "donate_title")
    }
}

// MARK: - QuickAmountButton

private struct QuickAmountButton: View {
    @Binding var selectedAmount: Amount
    var amount: GBP

    private var isSelected: Bool {
        selectedAmount.isQuick && selectedAmount.amount == amount
    }

    var body: some View {
        Text(amount, format: .currency(code: selectedAmount.currencyCode))
            .amountButton(
                isSelected: isSelected,
                action: {
                    selectedAmount = Amount(quick: amount)
                }
            )
    }
}

// MARK: - OtherAmountButton

private struct OtherAmountButton: View {
    @State private var isPresentingAlert = false
    @State private var customAmount = ""
    @Binding var selectedAmount: Amount

    private var amount: GBP? {
        !selectedAmount.isQuick ? selectedAmount.amount : nil
    }

    private var formattedAmount: String? {
        guard let amount else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = selectedAmount.currencyCode
        return formatter.string(from: NSDecimalNumber(decimal: amount))
    }

    private var text: Text {
        if let formattedAmount {
            Text("other_amount \(formattedAmount)")
        } else {
            Text("other_amount")
        }
    }

    private var isSelected: Bool {
        !selectedAmount.isQuick && selectedAmount.amount == amount
    }

    var body: some View {
        text
            .amountButton(
                isSelected: isSelected,
                action: {
                    isPresentingAlert = true
                }
            )
            .alert("enter_amount_gbp", isPresented: $isPresentingAlert) {
                TextField("enter_amount", text: $customAmount)
                    .keyboardType(.decimalPad)

                Button("confirm") {
                    if let amount = Decimal(string: customAmount) {
                        selectedAmount = Amount(other: amount)
                    }
                    customAmount = ""
                }

                Button("cancel", role: .cancel) {
                    customAmount = ""
                }
            }
    }
}

// MARK: - AmountButton

private struct AmountButton: ViewModifier {
    private let shape = RoundedRectangle(cornerRadius: .small)
    var isSelected: Bool
    var action: () -> Void

    private var backgroundColor: Color {
        isSelected ? .appBlue : .appWhite
    }

    private var foregroundColor: Color {
        isSelected ? .appWhite : .appBlue
    }

    func body(content: Content) -> some View {
        Button(action: action, label: {
            content
                .foregroundStyle(foregroundColor)
                .textStyle(.h2, fill: .center)
                .padding(.large)
                .background(backgroundColor)
                .clipShape(shape)
                .stickyShadow()
        })
    }
}

// MARK: - View + AmountButton

private extension View {
    func amountButton(
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        modifier(AmountButton(
            isSelected: isSelected,
            action: action
        ))
    }
}

// MARK: - View + Extensions

private extension View {
    func buttonEnabled(_ enabled: Bool) -> some View {
        disabled(!enabled)
            .opacity(enabled ? 1 : 0.25)
    }
}

// MARK: - Preview

#Preview {
    RootNavigationStack {
        DonateScreen()
    }
}
