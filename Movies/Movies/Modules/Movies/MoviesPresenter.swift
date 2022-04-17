//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Ahmed Madian on 16.04.22.
//

import Foundation

class MoviesPresenter {
    private unowned var view: MoviesViewProtocol
    private let interactor: MoviesInteractorProtocol
    private let wireframe: MoviesWireframeProtocol
    private var groupedMovies: [Int: [MovieViewModel]]
    private var selectedIndexPaths: [IndexPath]

    // MARK: - Init

    init(view: MoviesViewProtocol, interactor: MoviesInteractorProtocol, wireframe: MoviesWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.groupedMovies = [:]
        self.selectedIndexPaths = []
    }

    // TODO:- Move it to Interactor
    private func fetchMovies(completionHandler: @escaping (Error?) -> Void) {
        var movies = [Movie]()
        var favouriteMovieIds = [Favourite]()
        var error: Error?
        let dispatchGroup = DispatchGroup()

        // fetch all movies
        dispatchGroup.enter()
        interactor.fetchMovies {  result in
            switch result {
            case .success(let moviesArray):
                movies = moviesArray
            case .failure(let err):
                error = err
            }

            dispatchGroup.leave()
        }

        // fetch favourite movies
        dispatchGroup.enter()
        interactor.fetchFavourites { result in
            switch result {
            case .success(let favouriteIds):
                favouriteMovieIds = favouriteIds
            case .failure(let err):
                error = err
            }

            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            self.groupedMovies[MoviesSections.watched.rawValue] = movies
                .filter({ $0.isWatched })
                .sorted(by: {
                    if $0.rating == $1.rating {
                        return $0.title < $1.title
                    }

                    return $0.rating > $1.rating
                })
                .map({ MovieViewModel(movie: $0) })
            
            self.groupedMovies[MoviesSections.toWatch.rawValue] = movies
                .filter({ !$0.isWatched })
                .sorted(by: {
                    if $0.rating == $1.rating {
                        return $0.title < $1.title
                    }

                    return $0.rating > $1.rating
                })
                .map({ MovieViewModel(movie: $0) })

            self.groupedMovies[MoviesSections.favourites.rawValue] = favouriteMovieIds
                .compactMap { favourite in
                    movies.first(where: { $0.id == favourite.id })
                }
                .sorted(by: {
                    if $0.rating == $1.rating {
                        return $0.title < $1.title
                    }

                    return $0.rating > $1.rating
                })
                .map({ MovieViewModel(movie: $0) })

            completionHandler(error)
        }
    }
}

// MARK: - MoviesPresenterProtocol

extension MoviesPresenter: MoviesPresenterProtocol {
    func viewDidLoad() {
        view.showLoader()
        fetchMovies { [weak self] error in
            DispatchQueue.main.async {
                self?.view.hideLoader()

                if let error = error {
                    self?.wireframe.showErrorAlert(with: error.localizedDescription)
                }

                self?.view.updateView()
            }
        }
    }

    func shouldEnableNextButton() -> Bool {
        !selectedIndexPaths.isEmpty
    }

    func getNumberOfSections() -> Int {
        groupedMovies.keys.count
    }

    func numberOfMovies(at section: Int) -> Int {
        groupedMovies[section]?.count ?? .zero
    }

    func getMovieViewModelForCell(at indexPath: IndexPath) -> MovieViewModel? {
        groupedMovies[indexPath.section]?[indexPath.row]
    }

    func getTitle(for section: Int) -> String? {
        MoviesSections(rawValue: section)?.title
    }

    func didSelectItem(at indexPath: IndexPath) {
        var targetIndexPath: IndexPath?

        if selectedIndexPaths.contains(where: { $0 == indexPath }) {
            groupedMovies.values.forEach {
                $0.forEach { $0.set(isSelected: false) }
            }

            selectedIndexPaths = []
            view.updateView()
            return
        }

        groupedMovies.values.forEach {
            $0.forEach { $0.set(isSelected: false) }
        }

        let selectedMovie = groupedMovies[indexPath.section]?[indexPath.row]
        selectedMovie?.set(isSelected: true)

        if let selectedMovie = selectedMovie {
            groupedMovies.forEach { (key, value) in
                if value.contains(where: { $0.id == selectedMovie.id }) {
                    if key != indexPath.section {
                        if let row = value.firstIndex(where: { $0.id == selectedMovie.id }) {
                            targetIndexPath = IndexPath(row: row, section: key)
                            value[row].set(isSelected: true)
                        }
                    }
                }
            }
        }

        selectedIndexPaths = [indexPath]

        if let targetIndexPath = targetIndexPath {
            selectedIndexPaths.append(targetIndexPath)
            
        }

        view.updateView()
        if let targetIndexPath = targetIndexPath {
            view.scrollToItem(at: targetIndexPath)
        }
    }

    func didTapNextButton() {
        guard
            let selectedIndexPath = selectedIndexPaths.first,
            let selectedMovieViewModel = groupedMovies[selectedIndexPath.section]?[selectedIndexPath.row]
        else {
            return
        }

        wireframe.navigate(to: .detail(selectedMovieViewModel))
    }
}
