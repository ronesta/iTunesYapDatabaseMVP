//
//  SearchAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct SearchAssembly: SearchAssemblyProtocol {
    func build() -> UIViewController {
        let storageManager = DatabaseManager.shared
        let networkManager = NetworkManager(storageManager: storageManager)
        let viewController = SearchViewController()

        let presenter = SearchPresenter(view: viewController,
                                        networkManager: networkManager,
                                        storageManager: storageManager
        )
        let collectionViewDataSource = SearchCollectionViewDataSource(presenter: presenter)

        viewController.presenter = presenter
        viewController.storageManager = storageManager
        viewController.collectionViewDataSource = collectionViewDataSource
        presenter.view = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        let tabBarItem = UITabBarItem(title: "Search",
                                      image: UIImage(systemName: "magnifyingglass"),
                                      tag: 0)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }
}
