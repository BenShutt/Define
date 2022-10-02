//
//  LottieView.swift
//  Define
//
//  Created by Ben Shutt on 02/10/2022.
//

import SwiftUI
import Lottie

/// `UIViewRepresentable` wrapping a Lottie `AnimationView`
struct LottieView: UIViewRepresentable {

    /// Lottie JSON asset file
    var file: LottieFile

    /// Playback mode
    var loopMode: LottieLoopMode = .playOnce

    /// Content mode
    var contentMode: UIView.ContentMode = .scaleAspectFit

    /// `AnimationView`
    private let animationView = AnimationView()

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)

        animationView.animation = Animation.named(file.rawValue)
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.play()

        view.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<LottieView>
    ) {
        // do nothing
    }
}
