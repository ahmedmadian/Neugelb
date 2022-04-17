//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import Foundation
import UIKit

class MovieDetailViewController: BaseViewController {
    enum Constans {
        static let POSTER_IMAGE_VIEW_HEIGHT: CGFloat = 600
    }

    // MARK: - Views

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        if let url = presenter?.posterImageURL {
            imageView.loadImageFromUrl(url: url)
        }

        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(MovieDetailInfoItemCell.self,
                           forCellReuseIdentifier: String(describing: MovieDetailInfoItemCell.self))

        let headerView = posterImageView
        headerView.frame.size.height = Constans.POSTER_IMAGE_VIEW_HEIGHT
        tableView.tableHeaderView = headerView

        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    // MARK: - Presenter

    var presenter: MovieDetailPresenterProtocol?

    // MARK: - BaseViewController

    override func setupViewAppereance() {
        super.setupViewAppereance()

        title = presenter?.movieTitle
    }

    override func setupViewLayout() {
        super.setupViewLayout()

        view.addSubview(tableView, translatesAutoresizingMaskIntoConstraints: false)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - MovieDetailViewProtocol

extension MovieDetailViewController: MovieDetailViewProtocol {
}

// MARK: - UITableViewDataSource

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRows() ?? .zero
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieDetailInfoItemCell.self),
                                                     for: indexPath) as? MovieDetailInfoItemCell
        else {
            fatalError("cannot cast `\(String(describing: UITableViewCell.self))` to `\(String(describing: MovieDetailInfoItemCell.self))`")
        }

        if let presenter = presenter {
            cell.configView(with: presenter.getInfoItemViewModelForCell(at: indexPath))
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
