//
//  MoviesWireframe.swift
//  Movies
//
//  Created by Ahmed Madian on 16.04.22.
//

import Foundation

class MoviesWireframe: BaseWireframe {
    // MARK: - Init

    init() {
        let viewController = MoviesViewController()
        super.init(viewController: viewController)

        let moviesService = MoviesService()
        let moviesInteractor = MoviesInteractor(moviesService: moviesService)
        let moviesPresenter = MoviesPresenter(view: viewController,
                                              interactor: moviesInteractor,
                                              wireframe: self)
        viewController.presenter = moviesPresenter
    }
}

// MARK: - MoviesWireframeProtocol

extension MoviesWireframe: MoviesWireframeProtocol {
    func navigate(to option: MoviesWireframeNavigationOption) {
        switch option {
        case .detail(let movieViewModel):
            let movieDetailWireframe = MovieDetailWireframe(movieViewModel: movieViewModel)
            navigationController?.push(route: movieDetailWireframe)
        }
    }
}
