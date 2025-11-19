//
//  StorageManagerProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation

protocol ApplicationDatabaseProtocol: AnyObject {
    func saveAlbums(_ albums: [Album])

    func saveAlbumsForSearchQuery(albums: [Album], _ searchQuery: String)

    func loadAlbum(key: String) -> Album?

    func loadAlbums(forTerm term: String) -> [Album]?

    func saveSearchTerm(_ term: String)

    func getSearchHistory() -> [String]
}
