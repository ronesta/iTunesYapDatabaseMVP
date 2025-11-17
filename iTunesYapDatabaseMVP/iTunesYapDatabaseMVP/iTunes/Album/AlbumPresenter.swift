//
//  AlbumPresenter.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

final class AlbumPresenter {
    weak var view: AlbumViewInput?

    private let navigation: AlbumNavigation
    private let viewModel: AlbumViewModel?

    init(navigation: AlbumNavigation, viewModel: AlbumViewModel?) {
        self.navigation = navigation
        self.viewModel = viewModel
    }

    func configureAlbumDetails() {
        guard let viewModel else {
            return
        }

        view?.displayAlbumDetails(with: viewModel)
    }
}

// MARK: - AlbumViewOutput

extension AlbumPresenter: AlbumViewOutput {
    func viewDidLoad() {
        configureAlbumDetails()
    }
}
