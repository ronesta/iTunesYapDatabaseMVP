//
//  Album.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import Foundation

struct PostAlbums: Codable {
    let results: [Album]
}

struct Album: Codable {
    let artistId: Int
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let collectionPrice: Double
}
