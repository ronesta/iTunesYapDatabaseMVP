//
//  SearchHistoryInteractor.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 17.11.2025.
//

import Foundation

final class SearchHistoryInteractor {
    weak var presenter: SearchHistoryInteractorOutput?

    private let storageManager: StorageManagerProtocol

    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }
}

// MARK: SearchHistoryInteractorInput

extension SearchHistoryInteractor: SearchHistoryInteractorInput {
    func getSearchHistory() {
        let history = storageManager.getSearchHistory()
        presenter?.didGetSearchHistory(history)
    }
}
