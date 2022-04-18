//
//  MovieViewModel.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import Foundation

class MovieViewModel {
    // MARK: - Properties

    let id: Int
    let title: String
    let imageURL: URL?
    let overview: String
    let releaseDate: String?
    let rating: Double
    let originalLanguage: String
    private(set) var isSelected: Bool

    // MARK: - Init

    init(movie: Movie, isSelected: Bool = false) {
        self.id = movie.id
        self.title = movie.title
        // TODO: - Should be removed from here
        let urlString = "\(APIConstants.TMDB_IMAGES_BASE_URL)\(movie.posterPath ?? "")"
        self.imageURL = URL(string: urlString)
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.rating = movie.rating
        self.originalLanguage = movie.originalLanguage
        self.isSelected = isSelected
    }

    // MARK: - Operations

    func set(isSelected: Bool) {
        self.isSelected = isSelected
    }
}
