//
//  SearchHeaderView.swift
//  Define
//
//  Created by Ben Shutt on 04/10/2022.
//

import SwiftUI

struct SearchHeaderView: View {

    @Binding var searchText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Search")
                .textStyle(.title)
                .foregroundColor(.appBlack)

            Spacer()
                .frame(height: .small)

            Text("This is provided by xyz")
                .textStyle(.body)
                .foregroundColor(.appDarkBlue)

            Spacer()
                .frame(height: .large)

            InputTextField(
                text: $searchText,
                prompt: .EnterWordScreen.prompt,
                image: .search
            )
        }
        .padding(.largeMargins)
        .background(GradientBlurView())
        .shadow(color: .appBlack.opacity(0.2), radius: 2)
    }
}

// MARK: - PreviewProvider

struct SearchHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchHeaderView(searchText: .constant("Some search"))
            Spacer()
        }
    }
}
