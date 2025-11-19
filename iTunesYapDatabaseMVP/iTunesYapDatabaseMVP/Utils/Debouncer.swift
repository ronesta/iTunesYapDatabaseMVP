//
//  Debouncer.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 18.11.2025.
//

import UIKit
import Foundation

protocol DebouncerProtocol: AnyObject {
    var workItem: DispatchWorkItem { get }
    func debounce(action: @escaping () -> Void)
}

final class Debouncer: DebouncerProtocol {
    private(set) var workItem = DispatchWorkItem {}
    private let queue = DispatchQueue.main
    private var interval: TimeInterval

    init(interval: TimeInterval) {
        self.interval = interval
    }

    // MARK: - Debouncing function

    func debounce(action: @escaping (() -> Void)) {
        workItem.cancel()
        workItem = DispatchWorkItem { action() }
        queue.asyncAfter(deadline: .now() + interval, execute: workItem)
    }
}
