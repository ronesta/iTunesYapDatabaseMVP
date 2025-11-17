//
//  SearchViewProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

protocol SearchAssemblyProtocol {
    func build(searchQuery: String, coordinator: BaseCoordinatable) -> (UIViewController, SearchNavigation)
}

protocol SearchViewInput: AnyObject {
    func reloadData()
}

protocol SearchViewOutput: AnyObject {
    func viewDidLoad()

    /// Validates the search input text and updates the UI accordingly
    /// - Parameter text: The search text to validate
    func searchInputTextDidChange(with text: String)

    /// Returns number of items for collection view
    /// - Returns: number of items
    func numberOfItems() -> Int

    func cellModel(at indexPath: IndexPath) -> SearchCellKind

    /// Action on item selection
    /// - Parameter indexPath: The index path
    func didSelectItemAt(_ indexPath: IndexPath)
}

protocol SearchInteractorInput: AnyObject {
    func getAlbums(with name: String)
}

protocol SearchInteractorOutput: AnyObject {
    func didGetAlbums(responseModel: [Album])
    func didNotGetAlbums()
}
