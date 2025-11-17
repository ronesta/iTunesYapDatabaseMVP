//
//  SearchNavigation.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 14.11.2025.
//

import Foundation

enum SearchNavigationOut {
    case albumDetails(AlbumViewModel?)
}

class SearchNavigation: BaseNavigation {
    var out: ((SearchNavigationOut) -> Void)?

    init(out: ((SearchNavigationOut) -> Void)?, coordinator: BaseCoordinatable?) {
        self.out = out
        super.init(coordinator: coordinator)
    }
}
