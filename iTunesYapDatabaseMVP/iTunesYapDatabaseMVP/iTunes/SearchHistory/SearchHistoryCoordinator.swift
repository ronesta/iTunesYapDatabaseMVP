//
//  SearchHistoryCoordinator.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 17.11.2025.
//

import UIKit

final class SearchHistoryCoordinator: BaseCoordinator {
    private let searchHistoryAssembly: SearchHistoryAssemblyProtocol
    private let searchAssembly: SearchAssemblyProtocol

    init(
        searchHistoryAssembly: SearchHistoryAssemblyProtocol,
        searchAssembly: SearchAssemblyProtocol
    ) {
        self.searchHistoryAssembly = searchHistoryAssembly
        self.searchAssembly = searchAssembly
    }

    override func start() {
        showSearchHistory()
    }

    private func showSearchHistory() {
        let (viewController, navigation) = searchHistoryAssembly.build(coordinator: self)

        navigation.out = { [weak self] event in
            switch event {
            case let .search(searchQuery):
                self?.showSearchResult(with: searchQuery)
            }
        }
    }

    private func showSearchResult(with searchQuery: String) {
        let coordinator = SearchCoordinator(searchQuery: searchQuery)
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
    }
}
