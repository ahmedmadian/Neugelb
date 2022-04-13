//
//  MoviesRepository.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import Foundation

class MoviesRepository {
    func fetchMovies(completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "https://61efc467732d93001778e5ac.mockapi.io/movies/list") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let data = data else {
                return
            }

            do {
                let object = try JSONDecoder().decode(JSONWrapper<[Movie]>.self, from: data)
                completionHandler(Swift.Result.success(object.results))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
