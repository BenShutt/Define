//
//  ContentView.swift
//  Define
//
//  Created by Ben Shutt on 18/09/2022.
//

import SwiftUI

struct ContentView: View {

    @State var entry: String?

    var word: String {
        entry ?? "Loading..."
    }

    init() {
        SearchAPI(word: "prejudice").request { result in
            debugPrint(result)
        }
    }

    var body: some View {
        Text(word)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
