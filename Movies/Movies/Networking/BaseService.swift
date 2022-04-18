//
//  BaseService.swift
//  Movies
//
//  Created by Ahmed Madian on 17.04.22.
//

import Foundation

class BaseService {
    private var task: URLSessionTask?

    // MARK: - Operations

    func execute<Model: Codable>(endpoint: EndpointType, completionHandler: @escaping (Swift.Result<Model, Error>) -> Void) {
        let session = URLSession.shared

        do {
            let request = try self.buildRequest(from: endpoint)

            task = session.dataTask(with: request, completionHandler: { (data, response, error) in

                guard error == nil else {
                    completionHandler(.failure(error!))
                    return
                }

                guard
                    let response = response as? HTTPURLResponse
                else {
                    completionHandler(.failure(BaseServiceError.badRequest))
                    return
                }

                if (200...299).contains(response.statusCode) {
                    guard
                        let data = data
                    else {
                        completionHandler(.failure(BaseServiceError.serverError(message: "No Data")))
                        return
                    }

                    do {
                        let object = try JSONDecoder().decode(Model.self, from: data)
                        completionHandler(.success(object))
                    }
                    catch {
                        completionHandler(Swift.Result.failure(BaseServiceError.parsingError))
                    }

                } else {
                    completionHandler(.failure(self.handleUnsuccessfulStatusCode(response.statusCode)))
                }

            })
        } catch {
            completionHandler(.failure(error))
        }

        task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    private func buildRequest(from route: EndpointType) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)

        request.httpMethod = route.httpMethod.rawValue

        return request
    }

    private func handleUnsuccessfulStatusCode(_ statusCode: Int) -> BaseServiceError {
        switch statusCode {
        case 401...500: return .authenticationError
        case 501...599: return .badRequest
        default: return .serverError(message: "Server Error \(statusCode)")
        }
    }
}
