//
//  Favourite.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import Foundation

struct Favourite: Codable {
    let id: Int

    enum CodingKeys: String, CodingKey {
        case id
    }
}
