//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Ahmed Madian on 16.04.22.
//

import Foundation

class MoviesInteractor {
    private let moviesService: MoviesServiceProtocol

    // MARK: - Init

    init(moviesService: MoviesServiceProtocol) {
        self.moviesService = moviesService
    }
}

// MARK: - MoviesInteractorProtocol

extension MoviesInteractor: MoviesInteractorProtocol {
    func fetchMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        moviesService.fetchMovies { result in
            completionHandler(result)
        }
    }

    func fetchFavourites(completionHandler: @escaping (Result<[Favourite], Error>) -> Void) {
        moviesService.fetchFavourites { result in
            completionHandler(result)
        }
    }
}
