//
//  MoviesProtocols.swift
//  Movies
//
//  Created by Ahmed Madian on 16.04.22.
//

import Foundation

protocol MoviesViewProtocol: ViewProtocol {
    func updateView()
    func scrollToItem(at indexPath: IndexPath)
}

protocol MoviesPresenterProtocol: PresenterProtocol {
    func shouldEnableNextButton() -> Bool
    func getNumberOfSections() -> Int
    func numberOfMovies(at section: Int) -> Int
    func getMovieViewModelForCell(at indexPath: IndexPath) -> MovieViewModel?
    func getTitle(for section: Int) -> String?
    func didSelectItem(at indexPath: IndexPath)
}

protocol MoviesInteractorProtocol: InteractorProtocol {
    func fetchMovies(completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void)
    func fetchFavourites(completionHandler: @escaping (Swift.Result<[Favourite], Error>) -> Void)
}

protocol MoviesWireframeProtocol: WireframeProtocol {
     func navigate(to option: MoviesWireframeNavigationOption)
}

enum MoviesWireframeNavigationOption {
    case detail(Movie)
}
