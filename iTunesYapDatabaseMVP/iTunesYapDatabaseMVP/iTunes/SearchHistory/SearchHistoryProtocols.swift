//
//  SearchHistoryViewProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit.UIViewController

protocol SearchHistoryAssemblyProtocol {
    func build(coordinator: BaseCoordinatable) -> (UIViewController, SearchHistoryNavigation)
}

protocol SearchHistoryViewInput: AnyObject {
    func reloadData()

    func updateSearchHistory(_ history: [String])
}

protocol SearchHistoryViewOutput: AnyObject {
    func viewWillAppear()

    func didSelectRowAt(_ indexPath: IndexPath)

    func numberOfRows() -> Int

    func cellModel(at indexPath: IndexPath) -> SearchHistoryCellKind
}

protocol SearchHistoryInteractorInput: AnyObject {
    func getSearchHistory()
}

protocol SearchHistoryInteractorOutput: AnyObject {
    func didGetSearchHistory(_ history: [String])
    func didNotSearchHistory()
}
