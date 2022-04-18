//
//  BaseServiceError.swift
//  Movies
//
//  Created by Ahmed Madian on 18.04.22.
//

import Foundation

enum BaseServiceError: LocalizedError {
    case parsingError
    case serverError(message: String)
    case parametersNil
    case encodingFailed
    case missingURL
    case authenticationError
    case badRequest
    
    var errorDescription: String? {
        switch self {
        case .parsingError: return "JSON Parsing Failure"
        case .serverError(let message): return "\(message)"
        case .parametersNil: return "Parameters were nil."
        case .encodingFailed: return "Parameter encoding failed."
        case .missingURL: return "URL is nil."
        case .authenticationError: return "Auth Error"
        case .badRequest: return "Bad Request"
        }
    }
}
