//
//  TestView.swift
//  Define
//
//  Created by Ben Shutt on 27/04/2023.
//

import SwiftUI

// white Color(white: 1)
// darkGray Color(white: 0.05)
// lightGray Color(white: 0.95)
// maize Color(red255: 251, green: 236, blue: 93)
// yellow Color(red255: 255, green: 234, blue: 0)
// blue #3498DB

// sticky shadow(color: Color(white: 0.05).opacity(0.05), radius: 15, x: 0, y: 2)
// container Color(white: 0.95).opacity(0.08), radius: 10, x: 0, y: 2)

struct TestView: View {
    var body: some View {
        VStack {
            Text("Welcome, Ben")
                .foregroundColor(Color(white: 0.05))
                .h1()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background {
                    GradientBlurView()
                        .ignoresSafeArea()
                        .shadow(color: Color(white: 0.05).opacity(0.05), radius: 15, x: 0, y: 2)
                }

            Color.white
                .frame(height: 200)
                .cornerRadius(10)
                .padding()
                .shadow(color: Color(white: 0.95), radius: 10, x: 0, y: 2)
                .overlay {
                    RadialGradient(
                        colors: [
                            Color(red255: 251, green: 236, blue: 93),
                            Color(red255: 255, green: 234, blue: 0)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 2 * .pi
                    )
                    .frame(height: 100)
                    .clipShape(Capsule())
                    .overlay {
                        Text("HEY")
                            .foregroundColor(Color(white: 0.05))
                            .h2()
                            .foregroundColor(Color(white: 0.05))
                    }
                }

            Spacer()
        }
        .background(Color(white: 0.95))
        .stickyButton(title: "TAP ME") {
            // do something
        }
    }
}

private struct BackgroundView: View {

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hexString: "85b4f2")!,
                    Color(hexString: "7Ec9DC")!
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

extension Color {

    /// Shorthand for creating a `Color` with RGBA ranges in [0, 255].
    ///
    /// - Parameters:
    ///   - colorSpace: Color space, defaults to `.sRGB`
    ///   - red: Red component in [0, 255]
    ///   - green: Green component in [0, 255]
    ///   - blue: Blue component in [0, 255]
    ///   - opacity: Opacity component in [0, 255], defaults to 255
    init(
        _ colorSpace: RGBColorSpace = .sRGB,
        red255 red: Double,
        green: Double,
        blue: Double,
        opacity: Double = 255
    ) {
        self.init(
            colorSpace,
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            opacity: opacity / 255
        )
    }
}

public extension Color {

    /// RGBA hex `String`
    typealias RGBAHex = String

    /// Initialize `Color` with the given hex `string`.
    ///
    /// The `string` can be of the form:
    /// - RGB (12-bit)
    /// - RGB (24-bit)
    /// - RGBA (32-bit)
    ///
    /// - Parameter string: `RGBAHex` hex formatted color
    init?(hexString string: RGBAHex) {
        // Trim non-alphanumerics (which includes the # character)
        let hex = string.trimmingCharacters(in: .hexadecimal.inverted)

        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, a) = (
                (int >> 8) * 17, // r
                (int >> 4 & 0xF) * 17, // g
                (int & 0xF) * 17, // b
                255 // a
            )
        case 6: // RGB (24-bit)
            (r, g, b, a) = (
                int >> 16, // r
                int >> 8 & 0xFF, // g
                int & 0xFF, // b
                255 // a
            )
        case 8: // RGBA (32-bit)
            (r, g, b, a) = (
                int >> 24, // r
                int >> 16 & 0xFF, // g
                int >> 8 & 0xFF, // b
                int & 0xFF // a
            )
        default:
            return nil
        }

        self.init(
            red255: Double(r),
            green: Double(g),
            blue: Double(b),
            opacity: Double(a)
        )
    }

    /// `Color` to RGB hex `String`
    ///
    /// - Parameter opacity: Include the opacity component
    func hexString(opacity: Bool = true) -> String {
        let rgba = self.rgba

        var hex = String(
            format: "#%02X%02X%02X",
            rgba.red.int255,
            rgba.green.int255,
            rgba.blue.int255
        )

        if opacity {
            hex += String(format: "%02X", rgba.opacity.int255)
        }

        return hex
    }
}

// MARK: - Double + Color
private extension Double {

    /// Convert to integer 255 color component
    var int255: Int {
        Int((self * 255).rounded())
    }
}

// MARK: - CharacterSet + Color
private extension CharacterSet {

    /// Hexadecimal characters (uppercase and lowercase)
    static var hexadecimal: CharacterSet {
        CharacterSet(charactersIn: "0123456789abcdefABCDEF")
    }
}

extension Color {

    /// Red, green, blue opacity components of a color.
    /// Components in the range [0, 1]
    struct RGBA {

        /// Red component
        var red: Double

        /// Green component
        var green: Double

        /// Blue component
        var blue: Double

        /// Opacity component
        var opacity: Double
    }

    /// Get `RGBA` components from `AppColor`
    ///
    /// - Note:
    /// There doesn't seem to be a SwiftUI way of extracting the RGBA components as of yet.
    var rgba: RGBA {
        let appColor = UIColor(self)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var opacity: CGFloat = 0
        appColor.getRed(&red, green: &green, blue: &blue, alpha: &opacity)

        return RGBA(
            red: Double(red),
            green: Double(green),
            blue: Double(blue),
            opacity: Double(opacity)
        )
    }
}
