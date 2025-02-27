//
//  AlbumPresenter.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

final class AlbumPresenter: AlbumPresenterProtocol {
    weak var view: AlbumViewProtocol?
    private let networkManager: NetworkManagerProtocol
    private let storageManager: StorageManagerProtocol

    private let album: Album

    init(view: AlbumViewProtocol?,
         networkManager: NetworkManagerProtocol,
         storageManager: StorageManagerProtocol,
         album: Album
    ) {
        self.view = view
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.album = album
    }

    func viewDidLoad() {
        loadAlbumDetails()
    }

    func loadAlbumDetails() {
        networkManager.loadImage(from: album.artworkUrl100) { [weak self] loadedImage in

            guard let self,
                  let loadedImage else {
                return
            }

            view?.displayAlbumDetails(album: album, image: loadedImage)
        }
    }
}
