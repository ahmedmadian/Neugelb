//
//  BaseViewController.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewAppereance()
        setupViewLayout()
    }

    func setupViewAppereance() {
        view.backgroundColor = UIColor.Neugelb.BACKGROUND_COLOR
    }

    func setupViewLayout() {
    }
}
