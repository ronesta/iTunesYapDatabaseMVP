//
//  SearchHistoryViewProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation

protocol SearchHistoryViewProtocol: AnyObject {
    func updateSearchHistory(_ history: [String])
}
