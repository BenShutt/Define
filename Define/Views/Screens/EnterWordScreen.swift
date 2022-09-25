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
            .padding(.margins)

            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else if !definitions.isEmpty {
                    Text(definitions.joined(separator: "\n"))
                } else if !viewModel.searchText.isEmpty {
                    Text("No definitions found for '\(viewModel.searchText)'")
                } else {
                    Text("Enter text")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - PreviewProvider

struct EnterWordScreen_Previews: PreviewProvider {
    static var previews: some View {
        EnterWordScreen()
    }
}
