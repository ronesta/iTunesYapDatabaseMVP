//
//  SearchHistoryViewController.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import UIKit

final class SearchHistoryViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    var presenter: SearchHistoryPresenterProtocol?
    var tableViewDataSource: SearchHistoryDataSourceProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadSearchHistory()
    }

    private func setupNavigationBar() {
        title = "History"
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .systemGray6

        tableView.dataSource = tableViewDataSource
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - SearchHistoryViewProtocol
extension SearchHistoryViewController: SearchHistoryViewProtocol {
    func updateSearchHistory(_ history: [String]) {
        tableViewDataSource?.searchHistory = history
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension SearchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let searchHistory = tableViewDataSource?.searchHistory, !searchHistory.isEmpty else {
            print("Search history is empty or nil.")
            return
        }

        let selectedTerm = searchHistory[indexPath.row]
        performSearch(for: selectedTerm)
    }

    func performSearch(for term: String) {
        guard let searchViewController = SearchAssembly().build() as? UINavigationController,
              let rootViewController = searchViewController.viewControllers.first as? SearchViewController else {
            return
        }

        rootViewController.searchBar.isHidden = true
        rootViewController.presenter?.searchAlbums(with: term)

        navigationController?.pushViewController(rootViewController, animated: true)
    }
}
