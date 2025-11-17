//
//  SceneDelegate.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let searchAssembly = SearchAssembly()
        let albumAssembly = AlbumAssembly()
        let searchHistoryAssembly = SearchHistoryAssembly()

        appCoordinator = AppCoordinator(
            searchAssembly: searchAssembly,
            albumAssembly: albumAssembly,
            searchHistoryAssembly: searchHistoryAssembly
        )

        appCoordinator.start()

        window.rootViewController = appCoordinator.tabBarController
        window.makeKeyAndVisible()
    }
}
