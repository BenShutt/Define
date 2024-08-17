//
//  TableViewController.swift
//  Define
//
//  Created by Ben Shutt on 16/08/2024.
//

import SwiftUI

/// A `UITableViewController` that maps a 2D array of models to cells configured
/// by SwiftUI's `UIHostingConfiguration`.
@MainActor class TableViewController<Model, Content: View>: UITableViewController {

    /// Cell re-use identifier
    private let reuseIdentifier = "\(TableViewController.self)Cell"

    /// The 2D array of modes to draw
    var data: [[Model]] = [] {
        didSet {
            guard isViewLoaded else { return }
            tableView.reloadData()
        }
    }

    /// Map the model to a view
    let content: (Model) -> Content

    // MARK: - Init

    /// Initialize with the view builder
    /// - Parameters:
    ///   - content: Mapping of model to view
    ///   - style: Table view style
    init(
        @ViewBuilder content: @escaping (Model) -> Content,
        style: UITableView.Style = .grouped
    ) {
        self.content = content
        super.init(style: style)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor(Color.screenBackground)
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: reuseIdentifier
        )
        tableView.tableHeaderView = UIView(frame: CGRect(
            x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude
        ))
        tableView.tableFooterView = UIView(frame: CGRect(
            x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude
        ))
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension

        if !data.isEmpty {
            tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        data.count
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        data[section].count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        let data = data[indexPath.section][indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration { content(data) }
            .background(Color.clear)
            .margins(.all, 0)
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    // MARK: Header

    override func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        0
    }

    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        UIView()
    }

    override func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        nil
    }

    // MARK: Footer

    override func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        0
    }

    override func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        UIView()
    }

    override func tableView(
        _ tableView: UITableView,
        titleForFooterInSection section: Int
    ) -> String? {
        nil
    }
}
