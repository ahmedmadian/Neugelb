//
//  BaseWireframe.swift
//  Movies
//
//  Created by Ahmed Madian on 16.04.22.
//

import UIKit

class BaseWireframe {
    private(set) var viewController: UIViewController

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }

    // MARK: - Init

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - WireframeProtocol

extension BaseWireframe: WireframeProtocol {
    func showErrorAlert(with message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: "❌ Error", message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: title, message: message, actions: [okAction])
    }

    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func present(wireframe: BaseWireframe, modalPresentationStyle: UIModalPresentationStyle, animated: Bool = true, completion: (() -> Void)? = nil) {
        wireframe.viewController.modalPresentationStyle = modalPresentationStyle
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}

extension UINavigationController {
    func push(route router: BaseWireframe, animated: Bool = true) {
        self.pushViewController(router.viewController, animated: animated)
    }

    func setRootRoute(_ route: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([route.viewController], animated: animated)
    }
}
