//
//  MovieDetailWireframe.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import Foundation

class MovieDetailWireframe: BaseWireframe {
    // MARK: - Init

    init(movieViewModel: MovieViewModel) {
        let viewController = MovieDetailViewController()

        super.init(viewController: viewController)

        let presenter = MovieDetailPresenter(view: viewController, movieViewModel: movieViewModel)
        viewController.presenter = presenter
    }
}

// MARK: - MovieDetailWireframeProtocol

extension MovieDetailWireframe: MovieDetailWireframeProtocol {
}
