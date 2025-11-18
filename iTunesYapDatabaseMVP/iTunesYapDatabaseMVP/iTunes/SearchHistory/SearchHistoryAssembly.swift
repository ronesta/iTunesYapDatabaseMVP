//
//  SearchHistoryAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct SearchHistoryAssembly: SearchHistoryAssemblyProtocol {
    func build(coordinator: BaseCoordinatable) -> (UIViewController, SearchHistoryNavigation) {
        let navigation = SearchHistoryNavigation(out: nil, coordinator: coordinator)
        let interactor = SearchHistoryInteractor(storageManager: DatabaseManager.shared)
        let presenter = SearchHistoryPresenter(
            interactor: interactor,
            navigation: navigation
        )
        let viewController = SearchHistoryViewController(presenter: presenter)

        navigation.viewController = viewController
        presenter.view = viewController
        interactor.presenter = presenter

        return (viewController, navigation)
    }
}
