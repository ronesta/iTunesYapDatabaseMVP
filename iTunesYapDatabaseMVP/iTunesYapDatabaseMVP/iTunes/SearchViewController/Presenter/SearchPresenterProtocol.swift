//
//  SearchPresenterProtocol.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 23.01.2025.
//

import Foundation
import UIKit

protocol SearchPresenterProtocol: AnyObject {
    func viewDidLoad(with term: String)

    func loadImage(for album: Album, completion: @escaping (UIImage?) -> Void)
}
