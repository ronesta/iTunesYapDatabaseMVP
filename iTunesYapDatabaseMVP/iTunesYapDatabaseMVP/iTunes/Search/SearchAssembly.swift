//
//  SearchAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct SearchAssembly: SearchAssemblyProtocol {
    func build(searchQuery: String?, coordinator: BaseCoordinatable) -> (UIViewController, SearchNavigation) {
        let iTunesService = ITunesService()
        let navigation = SearchNavigation(out: nil, coordinator: coordinator)
        let interactor = SearchInteractor(
            iTunesService: iTunesService,
            storageManager: ApplicationDatabase.shared
        )
        let presenter = SearchPresenter(
            searchQuery: searchQuery,
            interactor: interactor,
            navigation: navigation,
            storageManager: ApplicationDatabase.shared
        )
        let viewController = SearchViewController(presenter: presenter)

        navigation.viewController = viewController
        presenter.view = viewController
        interactor.presenter = presenter

        return (viewController, navigation)
    }
}
