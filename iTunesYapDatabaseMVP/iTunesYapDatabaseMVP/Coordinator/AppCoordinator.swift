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
        // 1) ТАБ "Search"
        let searchCoordinator = SearchCoordinator(
            searchQuery: "",
            searchAssembly: searchAssembly,
            albumAssembly: albumAssembly
        )

        // делаем навигейшн координатора табом
        searchCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 0
        )

        // добавляем как child-координатор и запускаем
        start(coordinator: searchCoordinator)

        // 2) ТАБ "History"
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

        // 3) Собираем таббар
        tabBarController.viewControllers = [
            searchCoordinator.navigationController,
            searchHistoryCoordinator.navigationController
        ]
    }
}
