//
//  ReferenceLibraryView.swift
//  Define
//
//  Created by Ben Shutt on 03/10/2023.
//

import SwiftUI

// TODO: Make screen with sticky button - rename file

struct ReferenceLibraryView: UIViewControllerRepresentable {

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
