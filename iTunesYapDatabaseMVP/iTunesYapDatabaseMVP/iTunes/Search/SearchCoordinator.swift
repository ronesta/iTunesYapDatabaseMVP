//
//  SearchCoordinator.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 17.11.2025.
//

import UIKit

final class SearchCoordinator: BaseCoordinator {
    private let searchQuery: String
    private let searchAssembly: SearchAssemblyProtocol
    private let albumAssembly: AlbumAssemblyProtocol

    init(
        searchQuery: String,
        searchAssembly: SearchAssemblyProtocol = SearchAssembly(),
        albumAssembly: AlbumAssemblyProtocol = AlbumAssembly(),
    ) {
        self.searchQuery = searchQuery
        self.searchAssembly = searchAssembly
        self.albumAssembly = albumAssembly
    }

    override func start() {
        showSearchViewController()
    }

    private func showSearchViewController() {
        let (viewController, navigation) = searchAssembly.build(searchQuery: searchQuery, coordinator: self)

        navigation.out = { [weak self] event in
            switch event {
            case let .albumDetails(viewModel):
                guard let viewModel else {
                    return
                }
                self?.showAlbum(with: viewModel)
            }
        }
    }

    private func showAlbum(with viewModel: AlbumViewModel) {
        let (viewController, navigation) = albumAssembly.build(
            coordinator: self,
            viewModel: viewModel
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
