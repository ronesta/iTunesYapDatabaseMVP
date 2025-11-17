//
//  SearchHistoryViewController.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import UIKit

final class SearchHistoryViewController: UIViewController {
    /// View representation of screen
    let customView = SearchHistoryView()
    private let presenter: SearchHistoryViewOutput

    /// Initializer
    /// - Parameter presenter: business logic handler
    init(presenter: SearchHistoryViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

    private func configureNavigationBar() {
        title = "History"
    }

    private func configureTableView() {
        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.tableView.register(
            SearchHistoryTableViewCell.self,
            forCellReuseIdentifier: String(describing: SearchHistoryTableViewCell.self)
        )
    }
}

// MARK: - SearchHistoryViewInput

extension SearchHistoryViewController: SearchHistoryViewInput {
    func updateSearchHistory(_ history: [String]) {}
    
    func reloadData() {
        customView.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension SearchHistoryViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: SearchHistoryTableViewCell.self),
            for: indexPath) as? SearchHistoryTableViewCell else {
            return UITableViewCell()
        }

        let viewModel = presenter.cellModel(at: indexPath)
        if case let .history(searchHistoryViewModel) = viewModel {
            cell.configure(with: searchHistoryViewModel)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
