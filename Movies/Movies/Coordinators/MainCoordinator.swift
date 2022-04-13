//
//  MainCoordinator.swift
//  Movies
//
//  Created by Ahmed Madian on 13.04.22.
//

import UIKit

class MainCoordinator: Coordinator {
    // MARK: - Properties

    var childCoordinators: [Coordinator]
    private let navigationController: UINavigationController

    // MARK: - Init

    required init(navigationController: UINavigationController) {
        childCoordinators = []
        self.navigationController = navigationController
    }

    // MARK: - Operations

    func start() {
        let viewController = ViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
