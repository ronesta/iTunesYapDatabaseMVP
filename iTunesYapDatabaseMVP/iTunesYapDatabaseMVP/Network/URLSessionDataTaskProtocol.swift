//
//  URLSessionDataTaskProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 19.11.2025.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
