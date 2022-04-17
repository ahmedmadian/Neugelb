//
//  BaseViewController.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Views

    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        view.addSubview(activity, translatesAutoresizingMaskIntoConstraints: false)

        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return activity
    }()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewAppereance()
        setupViewLayout()
    }

    // MARK: - View Setup

    func setupViewAppereance() {
        view.backgroundColor = UIColor.Neugelb.Background.PRIMARY
    }

    func setupViewLayout() {
    }
}

// MARK: - ViewProtocol

extension BaseViewController: ViewProtocol {
    func showLoader() {
        view.bringSubviewToFront(activity)
        activity.isHidden = false
        activity.startAnimating()
    }

    func hideLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}
