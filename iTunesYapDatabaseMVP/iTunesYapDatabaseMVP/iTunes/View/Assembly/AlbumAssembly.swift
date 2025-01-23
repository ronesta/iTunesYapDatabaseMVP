//
//  AlbumAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct AlbumAssembly: AlbumAssemblyProtocol {
    func build(with album: Album) -> UIViewController {
        let storageManager = DatabaseManager.shared
        let networkManager = NetworkManager(storageManager: storageManager)

        let presenter = AlbumPresenter(networkManager: networkManager,
                                       storageManager: storageManager,
                                       album: album
        )
        let albumViewController = AlbumViewController(presenter: presenter)

        presenter.view = albumViewController

        return albumViewController
    }
}
