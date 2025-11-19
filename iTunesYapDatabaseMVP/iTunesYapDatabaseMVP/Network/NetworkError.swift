//
//  NetworkError.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
    case badStatusCode(Int)
    case decoding(Error)
}
