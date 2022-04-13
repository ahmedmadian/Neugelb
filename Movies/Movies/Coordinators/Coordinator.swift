//
//  Coordinator.swift
//  Movies
//
//  Created by Ahmed Madian on 13.04.22.
//

import UIKit

protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }

    init(navigationController: UINavigationController)

    func start()
}
