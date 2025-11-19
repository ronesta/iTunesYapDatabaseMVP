//
//  NetworkManager.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 11.01.2025.
//

import Foundation

final class ITunesService: ITunesServiceProtocol {
    private let urlSession: URLSessionProtocol
    private let dispatchQueue: DispatchQueueProtocol
    private let decoder: JSONDecoder

    init(
        urlSession: URLSessionProtocol = URLSession.shared,
        dispatchQueue: DispatchQueueProtocol = DispatchQueue.main,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.dispatchQueue = dispatchQueue
        self.decoder = decoder
    }

    func loadAlbums(albumName: String, completion: @escaping (Result<[Album], Error>) -> Void) {
        let baseURL = "https://itunes.apple.com/search"
        let term = albumName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?term=\(term)&entity=album&attribute=albumTerm"

        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        urlSession.dataTask(with: url) { data, _, error in
            if let error {
                self.dispatchQueue.async  {
                    completion(.failure(error))
                }
                return
            }

            guard let data else {
                self.dispatchQueue.async  {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let albums = try self.decoder.decode(AlbumsResponse.self, from: data).results
                self.dispatchQueue.async  {
                    completion(.success(albums))
                }
            } catch {
                self.dispatchQueue.async  {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
