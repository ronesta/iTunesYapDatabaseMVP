//
//  Coordinator.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 15.11.2025.
//

import UIKit

@objc
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }

    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

@objc
protocol BaseCoordinatable: Coordinator {}

class BaseCoordinator: BaseCoordinatable {
    var navigationController = UINavigationController()
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?

    func start() {
        fatalError("Start method should be implemented.")
    }

    func start(coordinator: Coordinator) {
        childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }

    func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }

    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
