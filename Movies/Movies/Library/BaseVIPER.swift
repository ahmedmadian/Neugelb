//
//  BaseVIPER.swift
//  Movies
//
//  Created by Ahmed Madian on 16.04.22.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func showLoader()
    func hideLoader()
}

protocol InteractorProtocol: AnyObject {
}

protocol PresenterProtocol: AnyObject {
    func viewDidLoad()
}

extension PresenterProtocol {
    func viewDidLoad() {
        fatalError("Implementation pending...")
    }
}

protocol WireframeProtocol: AnyObject {
    func showErrorAlert(with message: String?)
    func showAlert(with title: String?, message: String?)
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
}
