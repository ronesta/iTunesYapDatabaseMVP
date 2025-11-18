//
//  SearchHistoryPresenter.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation

final class SearchHistoryPresenter {
    weak var view: SearchHistoryViewInput?

    private var cells = [[SearchHistoryCellKind]]()
    private var searchHistory = [String]()

    private let interactor: SearchHistoryInteractorInput
    private let navigation: SearchHistoryNavigation

    /// Initializer
    /// - Parameters:
    ///   - interactor: interactor, requests handler
    ///   - navigation: screen navigation
    init(interactor: SearchHistoryInteractorInput, navigation: SearchHistoryNavigation) {
        self.interactor = interactor
        self.navigation = navigation
    }
}

extension SearchHistoryPresenter: SearchHistoryViewOutput {
    func viewWillAppear() {
        interactor.getSearchHistory()
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        let history = searchHistory[indexPath.row]
        navigation.out?(.search(history))
    }

    func numberOfRows() -> Int {
        cells.first?.count ?? 0
    }
    
    func cellModel(at indexPath: IndexPath) -> SearchHistoryCellKind {
        cells[indexPath.section][indexPath.row]
    }
}

// MARK: SearchHistoryInteractorOutput

extension SearchHistoryPresenter: SearchHistoryInteractorOutput {
    func didGetSearchHistory(_ history: [String]) {
        searchHistory = history

        let rowCells: [SearchHistoryCellKind] = history.map { term in
            let viewModel = SearchHistoryCellKind.SearchHistoryViewModel(
                leftText: term,
                rightText: nil
            )
            return .history(viewModel)
        }

        cells = [rowCells]
        view?.reloadData()
    }

    func didNotSearchHistory() {}
}

