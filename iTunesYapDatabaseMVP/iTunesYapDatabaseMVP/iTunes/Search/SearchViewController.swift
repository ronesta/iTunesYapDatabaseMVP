//
//  ViewController.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    /// View representation of screen
    let customView = SearchView()
    private let presenter: SearchViewOutput

    /// Initializer
    /// - Parameter presenter: business logic handler
    init(presenter: SearchViewOutput) {
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
        configure()
        presenter.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    private func configure() {
        configureNavigationBar()
        configureCollectionView()
        configureActions()
    }

    private func configureNavigationBar() {
        navigationItem.titleView = customView.searchBar
        customView.searchBar.delegate = self
    }

    private func configureCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.register(
            AlbumCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: AlbumCollectionViewCell.self)
        )
    }

    private func configureActions() {
        customView.onSearchChanged = { [weak presenter] text in
            presenter?.searchInputTextDidChange(with: text)
        }
    }
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    func reloadData() {
        customView.collectionView.reloadData()
    }

    func setSearchBarHidden(_ hidden: Bool) {
        if hidden {
            navigationItem.titleView = nil
            customView.searchBar.isHidden = true
        } else {
            customView.searchBar.isHidden = false
            navigationItem.titleView = customView.searchBar
            customView.searchBar.delegate = self
        }
    }

    func setResultsVisibility(showResults: Bool) {
        customView.setResultsVisibility(showResults: showResults)
    }
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: AlbumCollectionViewCell.self),
            for: indexPath)
                as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }

        let viewModel = presenter.cellModel(at: indexPath)
        if case let .search(searchViewModel) = viewModel {
            cell.configure(with: searchViewModel)
        }

        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchInputTextDidChange(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.searchButtonClicked(with: searchBar.text)
    }
}
