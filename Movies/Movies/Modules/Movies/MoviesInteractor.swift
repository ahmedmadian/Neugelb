//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Ahmed Madian on 16.04.22.
//

import Foundation

class MoviesInteractor {
    private let moviesRepository: MoviesRepository

    // MARK: - Init

    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
}

// MARK: - MoviesInteractorProtocol

extension MoviesInteractor: MoviesInteractorProtocol {
    func fetchMovies(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        moviesRepository.fetchMovies { result in
            completionHandler(result)
        }
    }

    func fetchFavourites(completionHandler: @escaping (Result<[Favourite], Error>) -> Void) {
        moviesRepository.fetchFavourites { result in
            completionHandler(result)
        }
    }
}
