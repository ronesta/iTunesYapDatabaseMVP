//
//  SearchHistoryNavigationOut.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 17.11.2025.
//

import Foundation

enum AlbumNavigationOut {
    case back
}

class AlbumNavigation: BaseNavigation {
    var out: ((AlbumNavigationOut) -> Void)?

    init(out: ((AlbumNavigationOut) -> Void)?, coordinator: BaseCoordinatable?) {
        self.out = out
        super.init(coordinator: coordinator)
    }
}
