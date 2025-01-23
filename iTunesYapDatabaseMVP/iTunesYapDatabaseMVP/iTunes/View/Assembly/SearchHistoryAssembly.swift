//
//  SearchHistoryAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct SearchHistoryAssembly: SearchHistoryAssemblyProtocol {
    func build() -> UIViewController {
        let storageManager = DatabaseManager.shared
        let viewController = SearchHistoryViewController()

        let presenter = SearchHistoryPresenter(view: viewController,
                                               storageManager: storageManager
        )
        let tableViewDataSource = SearchHistoryTableViewDataSource()

        viewController.presenter = presenter
        viewController.tableViewDataSource = tableViewDataSource
        presenter.view = viewController

        let navigationController = UINavigationController(rootViewController: viewController)
        let tabBarItem = UITabBarItem(title: "History",
                                      image: UIImage(systemName: "clock"),
                                      tag: 1)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }
}
