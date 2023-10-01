//
//  WelcomeScreen.swift
//  Define
//
//  Created by Ben Shutt on 23/08/2023.
//

import SwiftUI
import AppIcon

struct WelcomeScreen: Screen {

    @Environment(\.dismiss) var dismiss

    var screen: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                WelcomeHeaderView(color: .appBlue)
                    .frame(maxWidth: .infinity)

                Text(verbatim: .WelcomeScreen.title)
                    .h1()
                    .padding(.top, 2 * .extraLarge)
                    .padding(.horizontal, .hMargin)

                if let appName = Bundle.main.appName {
                    Text(verbatim: .WelcomeScreen.subtitle(appName: appName))
                        .body()
                        .padding(.top, .large)
                        .padding(.horizontal, .hMargin)
                }
            }
            .multilineTextAlignment(.leading)
            .padding(.bottom, .vMargin)
        }
        .ignoresSafeArea(.all, edges: .top)
        .stickyButton(
            title: .Misc.continueButton,
            image: Image(systemName: "arrow.forward")
        ) {
            dismiss()
        }
        .interactiveDismissDisabled()
    }
}

// MARK: - WelcomeHeaderView

private struct WelcomeHeaderView: View {

    private let backgroundHeight: CGFloat = 200
    private let iconHeight: CGFloat = 150
    var color: Color

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [
                    color.opacity(0.1),
                    color.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: backgroundHeight)
            .clipShape(CurvedBottom())
            .shadow(.container)

            AppIcon(size: iconHeight, color: color)
                .padding(.top, backgroundHeight - iconHeight * 0.75)
        }
    }
}

// MARK: - WelcomeHeaderShape

private struct CurvedBottom: Shape {

    private let yScale: CGFloat = 0.8

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .init(x: rect.minX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY * yScale))
        path.addQuadCurve(
            to: .init(x: rect.minX, y: rect.maxY * yScale),
            control: .init(x: rect.midX, y: rect.maxY)
        )
        path.closeSubpath()
        return path
    }
}

// MARK: - PreviewProvider

#Preview {
    Color.white
        .sheet(isPresented: .constant(true), content: {
            WelcomeScreen()
        })
}
