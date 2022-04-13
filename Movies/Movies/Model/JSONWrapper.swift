//
//  JSONWrapper.swift
//  Movies
//
//  Created by Ahmed Madian on 14.04.22.
//

import Foundation

struct JSONWrapper<T>: Codable where T: Codable {
    let results: T

    enum CodingKeys: String, CodingKey {
        case results
    }
}
