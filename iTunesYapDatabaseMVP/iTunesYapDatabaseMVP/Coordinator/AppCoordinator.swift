//
//  AppCoordinator.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.11.2025.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    let tabBarController = UITabBarController()

    private let searchAssembly: SearchAssemblyProtocol
    private let albumAssembly: AlbumAssemblyProtocol
    private let searchHistoryAssembly: SearchHistoryAssemblyProtocol

    init(
        searchAssembly: SearchAssemblyProtocol,
        albumAssembly: AlbumAssemblyProtocol,
        searchHistoryAssembly: SearchHistoryAssemblyProtocol
    ) {
        self.searchAssembly = searchAssembly
        self.albumAssembly = albumAssembly
        self.searchHistoryAssembly = searchHistoryAssembly
        super.init()
    }

    override func start() {
        showRootTabs()
    }

    private func showRootTabs() {
        configureTabBarAppearance()
        
        let searchCoordinator = SearchCoordinator(
            searchAssembly: searchAssembly,
            albumAssembly: albumAssembly
        )

        searchCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 0
        )

        start(coordinator: searchCoordinator)

        let searchHistoryCoordinator = SearchHistoryCoordinator(
            searchHistoryAssembly: searchHistoryAssembly,
            searchAssembly: searchAssembly
        )

        searchHistoryCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(systemName: "clock"),
            tag: 1
        )

        start(coordinator: searchHistoryCoordinator)

        tabBarController.viewControllers = [
            searchCoordinator.navigationController,
            searchHistoryCoordinator.navigationController
        ]
    }

    private func configureTabBarAppearance() {
        let tabBar = tabBarController.tabBar
        tabBar.tintColor = .label
        tabBar.unselectedItemTintColor = .secondaryLabel
        tabBar.barTintColor = .systemBackground
        tabBar.isTranslucent = false

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
