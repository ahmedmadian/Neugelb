//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import Foundation

enum MovieDetailItem: Int {
    case description
    case rating
    case date
    case originalLanguage
}

class MovieDetailPresenter {
    private unowned var view: MovieDetailViewProtocol
    private let movieViewModel: MovieViewModel
    private lazy var movieDetailsInfo: [MovieDetailInfoItemViewModel] = [
        MovieDetailInfoItemViewModel(title: "Description", value: movieViewModel.overview),
        MovieDetailInfoItemViewModel(title: "Rating", value: String(movieViewModel.rating)),
        MovieDetailInfoItemViewModel(title: "Release Date", value: movieViewModel.releaseDate),
        MovieDetailInfoItemViewModel(title: "Original language", value: movieViewModel.originalLanguage),
    ]

    // MARK: - Init

    init(view: MovieDetailViewProtocol, movieViewModel: MovieViewModel) {
        self.view = view
        self.movieViewModel = movieViewModel
    }
}

// MARK: - MovieDetailPresenterProtocol

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    var movieTitle: String {
        movieViewModel.title
    }

    var posterImageURL: URL? {
        movieViewModel.imageURL
    }

    func numberOfRows() -> Int {
        movieDetailsInfo.count
    }

    func getInfoItemViewModelForCell(at indexPath: IndexPath) -> MovieDetailInfoItemViewModel {
        movieDetailsInfo[indexPath.row]
    }

    func getPosterImageURL() -> URL? {
        return movieViewModel.imageURL
    }
}
