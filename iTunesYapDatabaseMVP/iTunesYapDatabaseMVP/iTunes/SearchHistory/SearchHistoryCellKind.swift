//
//  SearchHistoryCellKind.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 17.11.2025.
//


enum SearchHistoryCellKind {
    case history(SearchHistoryViewModel)

    struct SearchHistoryViewModel {
        let leftText: String
        let rightText: String?
    }
}
