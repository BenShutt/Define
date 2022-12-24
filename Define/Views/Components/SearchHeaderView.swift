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
            Text(String.SearchHeaderView.title)
                .h1()

            Spacer()
                .frame(height: .medium)

            Text(String.SearchHeaderView.subtitle)
                .body()

            Spacer()
                .frame(height: .extraLarge)

            InputTextField(
                text: $searchText,
                prompt: .SearchHeaderView.prompt,
                image: .search
            )
        }
        .padding(.largeMargins)
        .background(
            GradientBlurView()
                .appShadow()
                .ignoresSafeArea()
        )
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
