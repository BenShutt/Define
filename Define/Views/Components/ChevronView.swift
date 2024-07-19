//
//  ChevronView.swift
//  Define
//
//  Created by Ben Shutt on 19/12/2022.
//

import SwiftUI

struct ChevronView: View {
    var body: some View {
        Image(.chevronRight)
            .systemImage(size: 16, weight: .heavy)
            .foregroundStyle(Color.appDarkGray)
    }
}

// MARK: - Preview

#Preview {
    ChevronView()
}
