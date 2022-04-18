//
//  BaseServiceTests.swift
//  MoviesTests
//
//  Created by Ahmed Madian on 18.04.22.
//

import XCTest
@testable import Movies

class BaseServiceTests: XCTestCase {
    enum APIConstantsTests {
        static let BASE_URL = "www.test.com"
    }

    enum StubEndpoint: String, EndpointType {
        case test1

        var baseURL: URL {
            guard
                let url = URL(string: APIConstantsTests.BASE_URL)
            else {
                fatalError(BaseServiceError.missingURL.localizedDescription)
            }

            return url
        }
        
        var path: String {
            rawValue
        }

        var httpMethod: HTTPMethod {
            .get
        }
    }

    private var service: BaseService?
    let stubEndpoint: StubEndpoint = .test1

    override func setUpWithError() throws {
        try super.setUpWithError()

        service = BaseService()
    }

    func testBuildRequest() {
        let expectedURL = URL(string: "www.test.com/test1")
        let request = try? service?.buildRequest(from: stubEndpoint)
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url, expectedURL)
    }

    func testHandleUnsuccessfulStatusCode() {
        let serviceError = service?.handleUnsuccessfulStatusCode(500)

        XCTAssertEqual(serviceError?.localizedDescription, BaseServiceError.authenticationError.localizedDescription)
    }
}
