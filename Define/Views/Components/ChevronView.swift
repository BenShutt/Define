//
//  ChevronView.swift
//  Define
//
//  Created by Ben Shutt on 19/12/2022.
//

import SwiftUI

/// `View` drawing a chevron
struct ChevronView: View {

    var body: some View {
        Image(systemName: "chevron.right")
            .resizable()
            .scaledToFit()
            .fontWeight(.black)
            .foregroundColor(Color.appDarkGray)
            .frame(width: 16, height: 16)
            .padding(.horizontal, 9)
            .padding(.vertical, 9)
            .background(Color.appLightGray)
            .cornerRadius(.cornerRadius)
            .compositingGroup()
            .shadow(color: .appBlack.opacity(0.15), radius: 1)
    }
}

// MARK: - Preview

#Preview {
    ChevronView()
}
