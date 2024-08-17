//
//  AnimatedTableView.swift
//  Define
//
//  Created by Ben Shutt on 16/08/2024.
//

import SwiftUI

// TODO: Use on WordScreen

/// The `onAppear` modifier can not be relied upon when scrolling a `LazyVStack`.
/// Fallback to using a `UITableView` since a `VStack` would not be memory efficient.
struct AnimatedTableView<Model, Content: View>: UIViewControllerRepresentable {
    @ViewBuilder var content: (Model) -> Content
    var data: [Model]

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = AnimatedTableViewController(content: content)
        viewController.data = [data]
        return viewController
    }

    func updateUIViewController(
        _ viewController: some UIViewController,
        context: Context
    ) {}
}

// MARK: - AnimatedTableViewController

private class AnimatedTableViewController<Model, Content: View>:
    TableViewController<Model, Content> {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let indexPaths = tableView.indexPathsForVisibleRows ?? []
        indexPaths.forEach { indexPath in
            if let cell = tableView.cellForRow(at: indexPath) {
                animate(cell: cell, at: indexPath)
            }
        }
    }

    private func animate(
        cell: UITableViewCell,
        at indexPath: IndexPath
    ) {
        let delay = TimeInterval(indexPath.row) * 0.25
        let translationY: CGFloat = 50
        let duration: TimeInterval = 0.5

        cell.transform = CGAffineTransform(
            translationX: 0,
            y: translationY
        )
        cell.alpha = 0

        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [.curveEaseIn],
            animations: {
                cell.transform = .identity
                cell.alpha = 1
            }
        )
    }
}

// MARK: - Preview

#Preview {
    AnimatedTableView(content: { color in
        color
            .frame(height: 200)
            .frame(maxWidth: .infinity)
    }, data: [
        Color.red,
        Color.green,
        Color.blue,
        Color.orange,
        Color.yellow,
        Color.purple,
        Color.black
    ])
}
