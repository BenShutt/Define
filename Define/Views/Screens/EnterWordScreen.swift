//
//  EnterWordScreen.swift
//  Define
//
//  Created by Ben Shutt on 24/09/2022.
//

import SwiftUI

/// `View` to input a word to search for definitions
struct EnterWordScreen: View {

    /// The search text
    @State private var search = ""

    /// `View` of the screen
    var body: some View {
        VStack {
            // InputTextField
            InputTextField(
                text: $search,
                prompt: .EnterWordScreen.prompt
            )
            .padding(.margins)

            // LoadingView
            LoadingView()
        }
    }
}

// MARK: - PreviewProvider

struct EnterWordScreen_Previews: PreviewProvider {
    static var previews: some View {
        EnterWordScreen()
    }
}
