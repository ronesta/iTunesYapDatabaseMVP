//
//  AlbumViewProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

protocol AlbumAssemblyProtocol {
    func build(coordinator: BaseCoordinatable, viewModel: AlbumViewModel?) -> (UIViewController, AlbumNavigation)
}

protocol AlbumViewInput: AnyObject {
    func displayAlbumDetails(with viewModel: AlbumViewModel)
}

protocol AlbumViewOutput: AnyObject {
    func viewDidLoad()
}
