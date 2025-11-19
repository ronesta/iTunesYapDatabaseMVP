//
//  DatabaseManager.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import Foundation
import UIKit
import YapDatabase

final class ApplicationDatabase: ApplicationDatabaseProtocol {
    static let shared = ApplicationDatabase()

    private enum Keys {
        static let albumsCollection = "albums"
        static let albumsOrderCollection = "albumsOrder"
        static let historyKey = "searchHistory"
        static let searchHistoryOrderCollection = "searchHistoryOrder"
    }

    private let database: YapDatabase
    private let connection: YapDatabaseConnection

    private init() {
        do {
            database = try ApplicationDatabase.setupDatabase()
            database.registerCodableSerialization(Album.self, forCollection: Keys.albumsCollection)
            connection = database.newConnection()
        } catch {
            fatalError("Failed to initialize YapDatabase with error: \(error)")
        }
    }

    private static func setupDatabase() throws -> YapDatabase {
        guard let baseDir = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            throw ApplicationDatabaseError.databaseInitializationFailed
        }

        let databasePath = baseDir.appendingPathComponent("database.sqlite")

        guard let database = YapDatabase(url: databasePath) else {
            throw ApplicationDatabaseError.databaseInitializationFailed
        }

        return database
    }

    func saveAlbums(_ albums: [Album]) {
        guard !albums.isEmpty else {
            return
        }

        connection.readWrite { transaction in
            for album in albums {
                let key = "\(album.collectionName + album.artistName)"
                transaction.setObject(
                    album,
                    forKey: key,
                    inCollection: Keys.albumsCollection
                )
            }
        }
    }

    func saveAlbumsForSearchQuery(albums: [Album], _ searchQuery: String) {
        guard !albums.isEmpty else {
            return
        }

        connection.readWrite { transaction in
            var albumKeys = transaction.object(
                forKey: searchQuery,
                inCollection: Keys.albumsOrderCollection
            ) as? [String] ?? []

            for album in albums {
                let key = "\(album.collectionName + album.artistName)"
                if !albumKeys.contains(key) {
                    albumKeys.append(key)
                }
            }

            transaction.setObject(
                albumKeys,
                forKey: searchQuery,
                inCollection: Keys.albumsOrderCollection
            )
        }
    }

    func loadAlbum(key: String) -> Album? {
        var album: Album?
        connection.read { transaction in
            album = transaction.object(forKey: key, inCollection: Keys.albumsCollection) as? Album
        }
        return album
    }

    func loadAlbums(forTerm term: String) -> [Album]? {
        var result: [Album]?

        connection.read { transaction in
            guard let order = transaction.object(
                forKey: term,
                inCollection: Keys.albumsOrderCollection
            ) as? [String] else {
                result = nil
                return
            }

            var albums = [Album]()
            albums.reserveCapacity(order.count)

            for key in order {
                if let album = transaction.object(forKey: key, inCollection: Keys.albumsCollection) as? Album {
                    albums.append(album)
                }
            }

            result = albums
        }

        return result
    }

    func saveSearchTerm(_ term: String) {
        connection.readWrite { transaction in
            var order = transaction.object(
                forKey: Keys.historyKey,
                inCollection: Keys.searchHistoryOrderCollection
            ) as? [String] ?? []

            order.removeAll { $0 == term }
            order.insert(term, at: 0)

            let maxHistoryItems = 20
            if order.count > maxHistoryItems {
                order = Array(order.prefix(maxHistoryItems))
            }

            transaction.setObject(order,forKey: Keys.historyKey,inCollection: Keys.searchHistoryOrderCollection)
        }
    }

    func getSearchHistory() -> [String] {
        var history = [String]()
        connection.read { transaction in
            history = transaction.object(
                forKey: Keys.historyKey,
                inCollection: Keys.searchHistoryOrderCollection
            ) as? [String] ?? []
        }
        return history
    }

    func clearAlbums() {
        connection.readWrite { transaction in
            transaction.removeAllObjects(inCollection: Keys.albumsCollection)
            transaction.removeAllObjects(inCollection: Keys.albumsOrderCollection)
        }
    }
}
