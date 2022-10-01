//
//  EnterWordScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// `View` to input a word to search for definitions
struct EnterWordScreen: Screen {

    /// `LookUpViewModel`
    @ObservedObject private var viewModel = LookUpViewModel()

    /// Definitions of entered word
    var definitions: [String] {
        viewModel.result.success?.definitions ?? []
    }

    /// `View` of the screen
    var screenBody: some View {
        VStack {
            InputTextField(
                text: $viewModel.searchText,
                prompt: .EnterWordScreen.prompt
            )

            Spacer()
                .frame(height: .large)

            if viewModel.isLoading {
                LoadingView()
            } else if !definitions.isEmpty {
                Text(definitions.joined(separator: "\n\n"))
                    .foregroundColor(.appGreen)
                Spacer()
                ButtonView(text: .EnterWordScreen.saveButton) {
                    saveWord(word: viewModel.searchText)
                }
            } else if !viewModel.searchText.isEmpty {
                Text(String.EnterWordScreen.empty(viewModel.searchText))
                    .foregroundColor(.appBrown)
            } else {
                Text(String.EnterWordScreen.enterWord)
            }

            Spacer()
        }
        .padding(.margins)
    }

    /// Save the given `word`
    /// - Parameter word: `String`
    private func saveWord(word: String) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}

// MARK: - PreviewProvider

struct EnterWordScreen_Previews: PreviewProvider {
    static var previews: some View {
        EnterWordScreen()
    }
}
