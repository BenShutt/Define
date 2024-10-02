//
//  CGRectTests.swift
//  DefineTests
//
//  Created by Ben Shutt on 21/12/2022.
//

import Testing
import SwiftUI

struct CGRectTests {
    let insetRect: CGRect

    init() {
        let rect = CGRect(x: 0, y: 0, width: 20, height: 10)
        insetRect = rect.insetBy(dx: 5, dy: 5)
    }

    // MARK: - Tests

    @Test func insetValues() {
        let lhs = insetRect
        let rhs = CGRect(x: 5, y: 5, width: 10, height: 0)

        expectEqual(lhs.origin.x, rhs.origin.x)
        expectEqual(lhs.origin.y, rhs.origin.y)
        expectEqual(lhs.size.width, rhs.size.width)
        expectEqual(lhs.size.height, rhs.size.height)
        #expect(lhs == rhs)
    }

    @Test func insetRectValues() {
        expectEqual(insetRect.minX, 5)
        expectEqual(insetRect.midX, 10)
        expectEqual(insetRect.maxX, 15)

        expectEqual(insetRect.minY, 5)
        expectEqual(insetRect.midY, 5)
        expectEqual(insetRect.maxY, 5)
    }

    // MARK: - Helper

    private func expectEqual(_ lhs: Double, _ rhs: Double) {
        #expect(lhs.isEqual(to: rhs))
    }
}

// MARK: - Double + Extensions

private extension Double {
    func isEqual(
        to other: Double,
        precision ε: Double = 0.00001
    ) -> Bool {
        abs(self - other) < ε
    }
}
