//
//  SearchViewProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation

protocol SearchViewProtocol: AnyObject {
    func updateAlbums(_ albums: [Album])
    
    func showError(_ message: String)
}
