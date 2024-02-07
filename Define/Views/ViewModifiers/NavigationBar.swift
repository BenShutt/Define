//
//  NavigationBar.swift
//  Define
//
//  Created by Ben Shutt on 30/10/2023.
//

import SwiftUI
import SwiftUIIntrospect

struct NavigationButton: Identifiable {
    var imageName: String
    var onTap: () -> Void

    var id: String { imageName }
}

/// Header view with only a title
struct NavigationBar: ViewModifier {

    var title: LocalizedStringKey
    var titleDisplayMode: NavigationBarItem.TitleDisplayMode
    var buttons: [NavigationButton]

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(titleDisplayMode)
            .toolbar {
                if !buttons.isEmpty {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        ForEach(buttons) { button in
                            Button(action: button.onTap) {
                                Image(systemName: button.imageName)
                            }
                        }
                    }
                }
            }
            .toolbarBackground(Color.clear, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

// MARK: - View + Extensions

extension View {

    func navigationBar(
        title: LocalizedStringKey,
        titleDisplayMode: NavigationBarItem.TitleDisplayMode = .automatic,
        buttons: [NavigationButton] = []
    ) -> some View {
        modifier(NavigationBar(
            title: title,
            titleDisplayMode: titleDisplayMode,
            buttons: buttons
        ))
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        Color.yellow
            //.screen()
            .navigationBar(title: "Preview Title")
    }
    .introspect(.navigationStack, on: .iOS(.v16, .v17)) { navigationController in
        let navigationBar = navigationController.navigationBar
        guard !navigationBar.subviews.contains(where: {
            $0 is GradientUIView
        }) else { return }

        navigationBar.setBackgroundImage(
            makeColorImage(size: CGSize(width: 40, height: 40)),
            for: .default
        )

        /*DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let gradientView = GradientUIView()
            navigationBar.insertSubview(gradientView, at: 0)
            gradientView.constrainToEdges(of: navigationBar)
        }*/
    }
}

func makeColorImage(size: CGSize) -> UIImage {
    UIGraphicsImageRenderer(size: size).image { context in
        UIColor.green.setFill()
        context.fill(CGRect(origin: .zero, size: size))
    }
}

class GradientUIView: UIView {

    private let colors: [Color] = [.blue, .green]

    private lazy var gradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = colors.map { UIColor($0).cgColor }
        layer.startPoint = .init(x: 0, y: 0)
        layer.endPoint = .init(x: 1, y: 1)
        layer.locations = [0, 1]
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .white
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    func constrainToEdges(of view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
