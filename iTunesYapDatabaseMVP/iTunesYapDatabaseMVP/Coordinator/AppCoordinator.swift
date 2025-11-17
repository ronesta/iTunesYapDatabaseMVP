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
        self.navigationController = UINavigationController()
        self.searchAssembly = searchAssembly
        self.albumAssembly = albumAssembly
        self.searchHistoryAssembly = searchHistoryAssembly
    }

    override func start() {
        showRootTabs()
    }

    private func showRootTabs() {
        // основной экран поиска
        let (searchViewController, navigation) = searchAssembly.build(coordinator: self)

        navigation.out = { [weak self] event in
            switch event {
            case let .albumDetails(viewModel):
                guard let viewModel else { return }
                self?.showAlbum(with: viewModel)
            }
        }

        navigationController.setViewControllers([searchViewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 0
        )

        // второй таб — History (если он у тебя есть)
        let historyVC = searchHistoryAssembly.build()
        let historyNav = UINavigationController(rootViewController: historyVC)
        historyNav.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(systemName: "clock"),
            tag: 1
        )

        tabBarController.viewControllers = [navigationController, historyNav]
    }

    private func showAlbum(with viewModel: AlbumViewModel) {
        let viewController = albumAssembly.build(
            coordinator: self,
            viewModel: viewModel
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
