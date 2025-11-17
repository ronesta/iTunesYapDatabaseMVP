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

    private let searchQuery: String
    private let interactor: SearchInteractorInput
    private let navigation: SearchNavigation

    init(searchQuery: String, interactor: SearchInteractorInput, navigation: SearchNavigation) {
        self.searchQuery = searchQuery
        self.interactor = interactor
        self.navigation = navigation
    }
}

// MARK: SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    func viewDidLoad() {
        interactor.getAlbums(with: searchQuery)
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
        view?.reloadData()
    }

    func didNotGetAlbums() {}
}
