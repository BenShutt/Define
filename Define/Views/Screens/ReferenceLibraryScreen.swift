//
//  ReferenceLibraryScreen.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

struct ReferenceLibraryScreen: Screen {

    var term: String
    var onWordSaved: () -> Void

    var screen: some View {
        ReferenceLibraryView(term: term)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .stickyButton(
                title: .WordScreen.saveButton,
                systemName: "plus"
            ) {
                onWordSaved()
            }
    }
}

// MARK: - ReferenceLibraryView

private struct ReferenceLibraryView: UIViewControllerRepresentable {

    var term: String

    func makeUIViewController(context: Context) -> some UIViewController {
        UIReferenceLibraryViewController(term: term)
    }

    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
        // Do nothing
    }
}

// MARK: - Preview

#Preview {
    Color.appWhite
        .sheet(isPresented: .constant(true)) {
            ReferenceLibraryScreen(term: "hello") {}
        }
}
