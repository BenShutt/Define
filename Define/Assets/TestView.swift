//
//  TestView.swift
//  Define
//
//  Created by Ben Shutt on 27/04/2023.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Text("Welcome, Ben")
                .foregroundColor(.white)
                .h1()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background {
                    BackgroundView()
                        .frame(height: 180)
                        .ignoresSafeArea()
                }

            Spacer()

            Text("Welcome, Ben")
                .foregroundColor(.white)
                .h1()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background {
                    BackgroundView2()
                        .frame(height: 180)
                        .ignoresSafeArea()
                }
        }
    }
}

private struct BackgroundView: View {

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color("new3"),
                    Color("new7")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

private struct BackgroundView2: View {

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color("blue2"),
                    Color("appBlue")
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            BlurView()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
