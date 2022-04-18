//
//  MoviesService.swift
//  Movies
//
//  Created by Ahmed Madian on 18.04.22.
//

import Foundation

protocol MoviesServiceProtocol: AnyObject {
    func fetchMovies(completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void)
    func fetchFavourites(completionHandler: @escaping (Swift.Result<[Favourite], Error>) -> Void)
}

// MARK: - BaseService

class MoviesService: BaseService {
}

// MARK: - MoviesServiceProtocol

extension MoviesService: MoviesServiceProtocol {
    func fetchMovies(completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void) {
        let endpoint = MoviesEndpoint.list

        execute(endpoint: endpoint) { (result: Result<JSONResponse<[Movie]>, Error>) in

            switch result {
            case .success(let success):
                completionHandler(.success(success.results))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }

    func fetchFavourites(completionHandler: @escaping (Swift.Result<[Favourite], Error>) -> Void) {
        let endpoint = MoviesEndpoint.favorites

        execute(endpoint: endpoint) { (result: Result<JSONResponse<[Favourite]>, Error>) in
            switch result {
            case .success(let success):
                completionHandler(.success(success.results))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
}
