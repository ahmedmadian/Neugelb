//
//  EndpointType.swift
//  Movies
//
//  Created by Ahmed Madian on 18.04.22.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}
