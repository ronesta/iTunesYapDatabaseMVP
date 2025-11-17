//
//  InstantArgentinaTransferInteractor.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 14.11.2025.
//

import Foundation

/// Entity for handling service requests on InstantArgentinaTransfer screen
final class SearchInteractor {
    /// Presenter-delegate handling interactor's responses
    weak var presenter: SearchInteractorOutput?

    private let iTunesService: ITunesServiceProtocol
    private let storageManager: StorageManagerProtocol

    init(iTunesService: ITunesServiceProtocol, storageManager: StorageManagerProtocol) {
        self.iTunesService = iTunesService
        self.storageManager = storageManager
    }
}

// MARK: SearchInteractorInput

extension SearchInteractor: SearchInteractorInput {
    func getAlbums(with name: String) {
        storageManager.saveSearchTerm(name)

        if let savedAlbums = storageManager.loadAlbums(forTerm: name) {
            presenter?.didGetAlbums(responseModel: savedAlbums)
        }

        iTunesService.loadAlbums(albumName: name) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter?.didGetAlbums(responseModel: response)
                self?.storageManager.saveAlbums(response)
                self?.storageManager.saveAlbumsForSearchQuery(albums: response, name)
            case .failure:
                self?.presenter?.didNotGetAlbums()
            }
        }
    }
}
