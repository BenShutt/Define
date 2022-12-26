//
//  CGRectTests.swift
//  DefineTests
//
//  Created by Ben Shutt on 21/12/2022.
//

import XCTest
import CoreGraphics

/// Test insetting of a `CGRect`
class CGRectTests: XCTestCase {

    /// Epsilon accuracy
    private static let ε = 0.00001

    /// Test `CGRect`
    private static let rect = CGRect(x: 0, y: 0, width: 20, height: 10)

    /// Test insetted `rect`
    private static let insetRect = rect.insetBy(dx: 5, dy: 5)

    // MARK: - Tests

    /// Test insetting of a rect
    func testInsetRect() {
        assertEqual(
            lhs: Self.insetRect,
            rhs: CGRect(x: 5, y: 5, width: 10, height: 0)
        )
    }

    /// Test min, mid, and max values in X and Y
    func testInsetRectValues() {
        XCTAssertEqual(Self.insetRect.minX, 5, accuracy: Self.ε)
        XCTAssertEqual(Self.insetRect.midX, 10, accuracy: Self.ε)
        XCTAssertEqual(Self.insetRect.maxX, 15, accuracy: Self.ε)

        XCTAssertEqual(Self.insetRect.minY, 5, accuracy: Self.ε)
        XCTAssertEqual(Self.insetRect.midY, 5, accuracy: Self.ε)
        XCTAssertEqual(Self.insetRect.maxY, 5, accuracy: Self.ε)
    }

    // MARK: - Helper

    /// Check `lhs` and `rhs` rects are equal
    /// - Parameters:
    ///   - lhs: `CGRect`
    ///   - rhs: `CGRect`
    private func assertEqual(lhs: CGRect, rhs: CGRect) {
        XCTAssertEqual(lhs.origin.x, rhs.origin.x, accuracy: Self.ε)
        XCTAssertEqual(lhs.origin.y, rhs.origin.y, accuracy: Self.ε)
        XCTAssertEqual(lhs.size.width, rhs.size.width, accuracy: Self.ε)
        XCTAssertEqual(lhs.size.height, rhs.size.height, accuracy: Self.ε)
    }
}
