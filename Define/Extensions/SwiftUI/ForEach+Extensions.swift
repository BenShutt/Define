//
//  ForEach+Extensions.swift
//  Define
//
//  Created by Ben Shutt on 19/09/2022.
//

import Foundation
import SwiftUI

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}
