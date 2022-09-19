//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import SwiftUI

/// View drawing the content of a `LookUpViewModel`
struct ContentView: View {

    /// `LookUpViewModel`
    @ObservedObject private var model = LookUpViewModel()

    /// Initializer
    init() {
        model.lookUp(word: "prejudice")
    }

    /// Draw `View`
    var body: some View {
        if model.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
        } else {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(values: model.definitions) {
                    Text($0)
                        .padding()
                }
            }
        }
    }
}

// MARK: - PreviewProvider

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
