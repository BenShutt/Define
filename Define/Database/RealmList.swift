//
//  RealmList.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation
import RealmSwift

/// `List` of a Realm
typealias RealmList<Element: RealmCollectionValue> = RealmSwift.List<Element>

extension RealmList {

    /// Make a new `RealmList` instance from `elements`
    /// - Parameter elements: `[Element]`
    /// - Returns: `RealmList<Element>`
    static func make<Element: RealmCollectionValue>(_ elements: [Element]) -> RealmList<Element> {
        let list = RealmList<Element>()
        list.append(objectsIn: elements)
        return list
    }
}
