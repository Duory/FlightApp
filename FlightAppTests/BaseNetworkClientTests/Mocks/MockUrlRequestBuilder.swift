//
//  MockUrlRequestBuilder.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class MockUrlRequestBuilder: URLRequestBuilder {
    var baseURL: URL?
    var error: Error?
    var buildCalled = false

    func baseURL(_ newBaseURL: URL) -> URLRequestBuilder {
        return self
    }

    func path(_ newPath: String) -> URLRequestBuilder {
        return self
    }

    func method(_ newMethod: HttpMethod) -> URLRequestBuilder {
        return self
    }

    func parameters(_ newParameters: [String: String]) -> URLRequestBuilder {
        return self
    }

    func object(_ newObject: AnyEncodable) -> URLRequestBuilder {
        return self
    }

    func headers(_ newHeaders: [String: String]) -> URLRequestBuilder {
        return self
    }

    func build() throws -> URLRequest {
        if let error = error { throw error }
        guard let baseURL = baseURL else { fatalError("baseURL should be set for tests") }

        buildCalled = true
        return URLRequest(url: baseURL)
    }
}
