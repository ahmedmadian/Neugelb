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

        let moviesRepository = MoviesRepository()
        let moviesInteractor = MoviesInteractor(moviesRepository: moviesRepository)
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
        case .detail(let movie):
            // TODO: Naivgate
            print(movie)
        }
    }
}
