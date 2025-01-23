//
//  SearchPresenter.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    private let networkManager: NetworkManagerProtocol
    private let storageManager: StorageManagerProtocol

    private var albums = [Album]()

    init(view: SearchViewProtocol? = nil,
         networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol
    ) {
        self.view = view
        self.networkManager = networkManager
        self.storageManager = storageManager
    }

    func searchAlbums(with term: String) {
        let savedAlbums = storageManager.loadAlbums(forTerm: term)

        if !savedAlbums.isEmpty {
            albums = savedAlbums
            view?.updateAlbums(albums)
            return
        }

        networkManager.loadAlbums(albumName: term) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let albums):
                DispatchQueue.main.async {
                    self.albums = albums.sorted { $0.collectionName < $1.collectionName }
                    self.view?.updateAlbums(self.albums)
                    self.storageManager.saveAlbums(self.albums)
                    self.storageManager.saveAlbumsForSearchQuery(albums: self.albums, term)
                    print("Successfully loaded \(albums.count) albums.")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    func loadImage(for album: Album, completion: @escaping (UIImage?) -> Void) {
        networkManager.loadImage(from: album.artworkUrl100, completion: completion)
    }
}
