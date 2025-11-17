//
//  SearchHistoryNavigationOut.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 17.11.2025.
//

import Foundation

enum SearchHistoryNavigationOut {
    case search(String)
}

class SearchHistoryNavigation: BaseNavigation {
    var out: ((SearchHistoryNavigationOut) -> Void)?

    init(out: ((SearchHistoryNavigationOut) -> Void)?, coordinator: BaseCoordinatable?) {
        self.out = out
        super.init(coordinator: coordinator)
    }
}
