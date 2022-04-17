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
    let title: String?
    let imageURL: URL?
    private(set) var isSelected: Bool

    // MARK: - Init

    init(movie: Movie, isSelected: Bool = false) {
        self.id = movie.id
        self.title = movie.title
        // TODO: - Should be removed from here
        let urlString = "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"
        self.imageURL = URL(string: urlString)
        self.isSelected = isSelected
    }

    // MARK: - Operations

    func set(isSelected: Bool) {
        self.isSelected = isSelected
    }
}
