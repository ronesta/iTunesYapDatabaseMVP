//
//  AlbumAssembly.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

struct AlbumAssembly: AlbumAssemblyProtocol {
    func build(coordinator: BaseCoordinatable, viewModel: AlbumViewModel?) -> (UIViewController, AlbumNavigation) {
        let navigation = AlbumNavigation(out: nil, coordinator: coordinator)
        let presenter = AlbumPresenter(navigation: navigation, viewModel: viewModel)
        let viewController = AlbumViewController(presenter: presenter)

        presenter.view = viewController

        return (viewController, navigation)
    }
}

