//
//  SearchPresenter.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

final class SearchPresenter {
    weak var view: SearchViewInput?

    private var cells = [[SearchCellKind]]()
    private var albums = [Album]()
    private var workItem: DispatchWorkItem?
    private var currentQuery: String = ""

    private let searchQuery: String?
    private let interactor: SearchInteractorInput
    private let navigation: SearchNavigation
    private let storageManager: ApplicationDatabaseProtocol
    private let debouncer = Debouncer(interval: 0.4)

    init(
        searchQuery: String?,
        interactor: SearchInteractorInput,
        navigation: SearchNavigation,
        storageManager: ApplicationDatabaseProtocol
    ) {
        self.searchQuery = searchQuery
        self.interactor = interactor
        self.navigation = navigation
        self.storageManager = storageManager
    }

    private func updateSearchResultData() {
        let rowCells: [SearchCellKind] = albums.map { album in
            let viewModel = SearchCellKind.SearchViewModel(
                artistName: album.artistName,
                collectionName: album.collectionName,
                artworkUrl100: album.artworkUrl100
            )
            return .search(viewModel)
        }

        cells = [rowCells]
        view?.setResultsVisibility(showResults: true)
        view?.reloadData()
    }

    private func initiateSearchOfAlbums(_ name: String) {
        workItem?.cancel()

        let item = DispatchWorkItem { [weak interactor] in
            interactor?.getAlbums(with: name)
        }

        workItem = item
        debouncer.debounce { [weak item] in
            item?.perform()
        }
    }
}

// MARK: SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    func viewDidLoad() {
        if let searchQuery, !searchQuery.isEmpty {
            currentQuery = searchQuery
            view?.setSearchBarHidden(true)
            interactor.getAlbums(with: searchQuery)
        }
    }

    func didSelectItemAt(_ indexPath: IndexPath) {
        let album = albums[indexPath.row]

        let viewModel = AlbumViewModel(
            artistId: album.artistId,
            artistName: album.artistName,
            collectionName: album.collectionName,
            artworkUrl100: album.artworkUrl100,
            collectionPrice: album.collectionPrice
        )

        navigation.out?(.albumDetails(viewModel))
    }

    func searchInputTextDidChange(with text: String) {
        currentQuery = text

        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            workItem?.cancel()
            albums = []
            cells = []
            view?.setResultsVisibility(showResults: true)
            view?.reloadData()
            return
        }

        initiateSearchOfAlbums(trimmed)
    }

    func searchButtonClicked(with text: String?) {
        guard let text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }

        currentQuery = text
        workItem?.cancel()

        storageManager.saveSearchTerm(text)
        interactor.getAlbums(with: text)
    }

    func numberOfItems() -> Int {
        albums.count
    }

    func cellModel(at indexPath: IndexPath) -> SearchCellKind {
        cells[indexPath.section][indexPath.row]
    }
}

// MARK: SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    func didGetAlbums(responseModel: [Album]) {
        albums = responseModel.sorted { $0.collectionName < $1.collectionName }
        updateSearchResultData()
    }

    func didNotGetAlbums() {
        view?.setResultsVisibility(showResults: false)
    }
}
