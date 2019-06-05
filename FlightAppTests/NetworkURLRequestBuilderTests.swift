//
//  NetworkURLRequestBuilderTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 05/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class NetworkURLRequestBuilderTests: XCTestCase {
    private enum TestData {
        static let userAgent = "test user agent"
        static let contentType = "test content type"
    }

    private var builder: URLRequestBuilder!

    override func setUp() {
        super.setUp()

        builder = NetworkURLRequestBuilder(
            serializer: HttpUrlParametersSerializer(),
            encoder: JSONNetworkEncoder(),
            userAgent: TestData.userAgent,
            contentType: TestData.contentType
        )
    }

    override func tearDown() {
        super.tearDown()

        builder = nil
    }

    func testURLRequestBuilderBuildCorrectGetRequest() {
        do {
            let path = "test/path"
            let method = HttpMethod.get
            let parameters = [ "parameter": "test parameter" ]
            let request = try builder
                .baseURL(TestConfiguration.baseURL)
                .path(path)
                .method(method)
                .parameters(parameters)
                .build()

            guard let url = request.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                XCTFail("No request url")
                return
            }

            let expectedURL = "\(TestConfiguration.baseURL)/\(path)?parameter=test%20parameter"
            SDAssertEqual(
                components.url?.absoluteString,
                expectedURL,
                "\(components.url?.absoluteString ?? "") should be equal to \(expectedURL)"
            )
            SDAssertEqual(
                request.httpMethod,
                HttpMethod.get.rawValue,
                "\(request.httpMethod ?? "") should be equal to \(HttpMethod.get.rawValue)"
            )
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
