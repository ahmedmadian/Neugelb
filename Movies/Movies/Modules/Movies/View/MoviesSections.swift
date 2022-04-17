//
//  MoviesSections.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import Foundation

enum MoviesSections: Int, CaseIterable {
    case favourites
    case watched
    case toWatch

    var title: String? {
        switch self {
        case .favourites:
            return "Favourites"
        case .watched:
            return "Watched"
        case .toWatch:
            return "To watch"
        }
    }
}
