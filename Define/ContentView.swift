//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(DictionaryAPIKey.apiKey ?? "")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
