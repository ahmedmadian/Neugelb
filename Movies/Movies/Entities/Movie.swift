//
//  Movie.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import Foundation

struct Movie: Codable {
    // MARK: - Properties

    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let popularity: Double
    let rating: Double
    let isWatched: Bool
    let backdropPath: String

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, rating, isWatched
    }
}
