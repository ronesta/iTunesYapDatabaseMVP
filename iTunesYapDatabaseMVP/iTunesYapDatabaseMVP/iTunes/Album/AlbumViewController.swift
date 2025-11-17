//
//  AlbumViewController.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import Foundation
import UIKit
import SnapKit

final class AlbumViewController: UIViewController {
    /// View representation of screen
    let customView = AlbumView()
    private let presenter: AlbumViewOutput

    /// Initializer
    /// - Parameter presenter: business logic handler
    init(presenter: AlbumViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureActions()
    }

    private func configureActions() {

    }
}

// MARK: - AlbumViewInput

extension AlbumViewController: AlbumViewInput {
    func displayAlbumDetails(with viewModel: AlbumViewModel) {
        customView.displayAlbumDetails(with: viewModel)
    }
}
