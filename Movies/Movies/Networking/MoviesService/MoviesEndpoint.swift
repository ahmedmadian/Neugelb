//
//  MoviesEndpoint.swift
//  Movies
//
//  Created by Ahmed Madian on 18.04.22.
//

import Foundation

enum MoviesEndpoint: String, EndpointType {
    case list
    case favorites

    var baseURL: URL {
        guard
            let url = URL(string: APIConstants.MOVIES_API_BASE_URL)
        else {
            fatalError(BaseServiceError.missingURL.localizedDescription)
        }

        return url
    }

    var path: String {
        "movies/\(rawValue)"
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .list:
            return .get
        case .favorites:
            return .get
        }
    }
}
