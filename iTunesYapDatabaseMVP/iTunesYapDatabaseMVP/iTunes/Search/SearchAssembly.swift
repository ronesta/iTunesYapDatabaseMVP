//
//  SearchAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct SearchAssembly: SearchAssemblyProtocol {
    func build(searchQuery: String, coordinator: BaseCoordinatable) -> (UIViewController, SearchNavigation) {
        let iTunesService = ITunesService(storageManager: DatabaseManager.shared)
        let navigation = SearchNavigation(out: nil, coordinator: coordinator)
        let interactor = SearchInteractor(
            iTunesService: iTunesService,
            storageManager: DatabaseManager.shared
        )
        let presenter = SearchPresenter(
            searchQuery: searchQuery,
            interactor: interactor,
            navigation: navigation
        )
        let viewController = SearchViewController(presenter: presenter)

        navigation.viewController = viewController
        presenter.view = viewController
        interactor.presenter = presenter

        return (viewController, navigation)
    }
}
