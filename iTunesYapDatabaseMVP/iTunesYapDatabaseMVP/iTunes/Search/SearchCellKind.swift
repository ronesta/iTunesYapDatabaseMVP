//
//  SearchCellKind.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 13.11.2025.
//

enum SearchCellKind {
    case search(SearchViewModel)

    struct SearchViewModel {
        let artistName: String
        let collectionName: String
        let artworkUrl100: String
    }
}
