//
//  MovieDetailProtocols.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import Foundation

protocol MovieDetailViewProtocol: ViewProtocol {
}

protocol MovieDetailPresenterProtocol: PresenterProtocol {
    var movieTitle: String { get }
    var posterImageURL: URL? { get }
    func numberOfRows() -> Int
    func getInfoItemViewModelForCell(at indexPath: IndexPath) -> MovieDetailInfoItemViewModel
}

protocol MovieDetailInteractorProtocol: InteractorProtocol {
}

protocol MovieDetailWireframeProtocol: WireframeProtocol {
}
