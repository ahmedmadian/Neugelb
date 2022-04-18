//
//  JSONResponse.swift
//  Movies
//
//  Created by Ahmed Madian on 18.04.22.
//

import Foundation

struct JSONResponse<T>: Codable where T: Codable {
    let results: T

    enum CodingKeys: String, CodingKey {
        case results
    }
}
