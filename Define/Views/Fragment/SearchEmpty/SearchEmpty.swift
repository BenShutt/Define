//
//  SearchEmptyModel.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import Foundation

/// Empty state search UI when the user has't entered any text
struct SearchEmpty: SearchEmptyView {

    var lottie: LottieFile {
        .searchEmpty
    }

    var title: String {
        .Search.Empty.title
    }

    var subtitle: String {
        .Search.Empty.subtitle
    }
}