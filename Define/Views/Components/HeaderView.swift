//
//  HeaderView.swift
//  Define
//
//  Created by Ben Shutt on 28/04/2023.
//

import SwiftUI

/// Header view
struct HeaderView: View {

    /// Text for the title label
    var title: String

    /// Optional text for the subtitle label
    var subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text(verbatim: title)
                .h1()

            if let subtitle {
                Text(verbatim: subtitle)
                    .body()
            }
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.extraLarge)
        .background {
            GradientBlurView()
                .ignoresSafeArea()
                .shadow(.sticky)
        }
    }
}

// MARK: - PreviewProvider

struct HeaderView_Previews: PreviewProvider {

    static var previews: some View {
        ScreenBody {
            VStack {
                HeaderView(
                    title: .HomeScreen.title,
                    subtitle: .HomeScreen.subtitle
                )

                Spacer()
            }
        }
    }
}
