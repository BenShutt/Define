//
//  MappedDBModel.swift
//  Define
//
//  Created by Ben Shutt on 24/12/2022.
//

import Foundation

/// A database model that maps to an app model
protocol MappedDBModel {

    /// Associated model
    associatedtype Model

    /// Map to `Model`
    var model: Model { get }
}
