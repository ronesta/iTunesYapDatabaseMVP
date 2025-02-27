//
//  SearchHistoryAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct SearchHistoryAssembly {
    func build() -> UIViewController {
        let storageManager = DatabaseManager.shared
        let viewController = SearchHistoryViewController()

        let presenter = SearchHistoryPresenter(view: viewController,
                                               storageManager: storageManager
        )
        let tableViewDataSource = SearchHistoryTableViewDataSource()

        viewController.presenter = presenter
        viewController.tableViewDataSource = tableViewDataSource

        configureOnSelect(for: viewController, with: tableViewDataSource)

        let navigationController = UINavigationController(rootViewController: viewController)
        let tabBarItem = UITabBarItem(title: "History",
                                      image: UIImage(systemName: "clock"),
                                      tag: 1)
        tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }

    private func configureOnSelect(for viewController: SearchHistoryViewController,
                                   with tableViewDataSource: SearchHistoryTableViewDataSource
    ) {
        viewController.onSelect = { [weak viewController] indexPath in
            let selectedTerm = tableViewDataSource.searchHistory[indexPath.row]
            let searchAssembly = SearchAssembly()

            guard let searchViewController = searchAssembly.build() as? UINavigationController,
                  let rootViewController = searchViewController.viewControllers.first as? SearchViewController else {
                return
            }

            rootViewController.searchBar.isHidden = true
            rootViewController.presenter?.viewDidLoad(with: selectedTerm)

            viewController?.navigationController?.pushViewController(rootViewController, animated: true)
        }
    }
}
