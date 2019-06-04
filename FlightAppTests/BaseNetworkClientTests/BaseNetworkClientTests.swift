//
//  BaseNetworkClientTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class BaseNetworkClientTests: XCTestCase {
    private struct Nil: Codable { }

    private enum TestData {
        static let object = TestModel(test: "test")
    }

    private let mockHttp = MockHttp()
    private let mockUrlRequestBuilder = MockUrlRequestBuilder()
    private let mockNetworkDecoder = MockNetworkDecoder()

    private var networkClient: CodableNetworkClient!

    override func setUp() {
        super.setUp()

        networkClient = BaseNetworkClient(
            baseURL: TestConfiguration.baseURL,
            http: mockHttp,
            urlRequestBuilder: mockUrlRequestBuilder,
            decoder: mockNetworkDecoder,
            completionQueue: .main
        )
    }

    override func tearDown() {
        super.tearDown()

        networkClient = nil
    }

    func testNetworkClientSuccessRequestCall() {
        mockHttp.data = Data()
        mockHttp.urlResponse = HTTPURLResponse(url: TestConfiguration.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockUrlRequestBuilder.baseURL = TestConfiguration.baseURL
        mockNetworkDecoder.object = TestData.object

        expect("Network client success request call") { description, expectation in
            let task = networkClient.request(
                method: .post,
                path: "",
                parameters: [:],
                object: Nil?.none,
                headers: [:]
            ) { (result: Result<TestModel, NetworkError>) -> Void in
                guard let object = SDAssertSuccess(result, description, expectation) else { return }

                guard
                    SDAssertTrue(self.mockHttp.dataTaskCalled, description, expectation),
                    SDAssertTrue(self.mockUrlRequestBuilder.buildCalled, description, expectation),
                    SDAssertTrue(self.mockNetworkDecoder.decodeCalled, description, expectation),
                    SDAssertEqual(object, TestData.object, description, expectation)
                else { return }

                expectation.fulfill()
            }
            XCTAssertNotNil(task, description)
        }
    }

    func testNetworkClientReturnsBuilderError() {
        mockUrlRequestBuilder.error = NetworkURLRequestBuilderError.baseURLIsNil

        expect("Network client returns builder error") { description, expectation in
            let task = networkClient.request(
                method: .post,
                path: "",
                parameters: [:],
                object: Nil?.none,
                headers: [:]
            ) { (result: Result<TestModel, NetworkError>) -> Void in
                guard let error = SDAssertFailure(result, description, expectation) else { return }

                guard case NetworkError.urlBuild(let urlBuildError) = error else {
                    XCTFail("Error from result should be urlBuild")
                    expectation.fulfill()
                    return
                }

                guard case NetworkURLRequestBuilderError.baseURLIsNil = urlBuildError else {
                    XCTFail("urlBuildError should be NetworkURLRequestBuilderError.baseURLIsNil")
                    expectation.fulfill()
                    return
                }

                expectation.fulfill()
            }
            XCTAssertNil(task, description)
        }
    }

    func testNetworkClientReturnsClientError() {
        mockHttp.error = MockHttpError.test
        mockUrlRequestBuilder.baseURL = TestConfiguration.baseURL

        expect("Network client returns client error") { description, expectation in
            let task = networkClient.request(
                method: .post,
                path: "",
                parameters: [:],
                object: Nil?.none,
                headers: [:]
            ) { (result: Result<TestModel, NetworkError>) -> Void in
                guard let error = SDAssertFailure(result, description, expectation) else { return }

                guard case NetworkError.clientError(let clientError) = error else {
                    XCTFail("Error from result should be clientError")
                    expectation.fulfill()
                    return
                }

                guard case MockHttpError.test = clientError else {
                    XCTFail("urlBuildError should be MockHttpError.test")
                    expectation.fulfill()
                    return
                }

                expectation.fulfill()
            }
            XCTAssertNotNil(task, description)
        }
    }

    func testNetworkClientReturnsNoResponseError() {
        mockUrlRequestBuilder.baseURL = TestConfiguration.baseURL

        expect("Network client returns no response error") { description, expectation in
            let task = networkClient.request(
                method: .post,
                path: "",
                parameters: [:],
                object: Nil?.none,
                headers: [:]
            ) { (result: Result<TestModel, NetworkError>) -> Void in
                guard let error = SDAssertFailure(result, description, expectation) else { return }

                guard case NetworkError.noResponse = error else {
                    XCTFail("Error from result should be noResponse")
                    expectation.fulfill()
                    return
                }

                expectation.fulfill()
            }
            XCTAssertNotNil(task, description)
        }
    }

    func testNetworkClientReturnsNetworkError() {
        let statusCode = 500
        let urlResponse = HTTPURLResponse(url: TestConfiguration.baseURL, statusCode: statusCode, httpVersion: nil, headerFields: [:])
        mockHttp.urlResponse = urlResponse
        mockUrlRequestBuilder.baseURL = TestConfiguration.baseURL

        expect("Network client returns network error") { description, expectation in
            let task = networkClient.request(
                method: .post,
                path: "",
                parameters: [:],
                object: Nil?.none,
                headers: [:]
            ) { (result: Result<TestModel, NetworkError>) -> Void in
                guard let error = SDAssertFailure(result, description, expectation) else { return }

                guard case NetworkError.networkError(let code, let response) = error else {
                    XCTFail("Error from result should be networkError")
                    expectation.fulfill()
                    return
                }

                guard
                    SDAssertEqual(code, statusCode, description, expectation),
                    SDAssertEqual(response, urlResponse, description, expectation)
                else { return }

                expectation.fulfill()
            }
            XCTAssertNotNil(task, description)
        }
    }

    func testNetworkClientReturnsEmptyDataError() {
        mockHttp.urlResponse = HTTPURLResponse(url: TestConfiguration.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockUrlRequestBuilder.baseURL = TestConfiguration.baseURL

        expect("Network client returns empty data error") { description, expectation in
            let task = networkClient.request(
                method: .post,
                path: "",
                parameters: [:],
                object: Nil?.none,
                headers: [:]
            ) { (result: Result<TestModel, NetworkError>) -> Void in
                guard let error = SDAssertFailure(result, description, expectation) else { return }

                guard case NetworkError.emptyData = error else {
                    XCTFail("Error from result should be emptyData")
                    expectation.fulfill()
                    return
                }

                expectation.fulfill()
            }
            XCTAssertNotNil(task, description)
        }
    }

    func testNetworkClientReturnsDecodeFailedError() {
        mockHttp.data = Data()
        mockHttp.urlResponse = HTTPURLResponse(url: TestConfiguration.baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockUrlRequestBuilder.baseURL = TestConfiguration.baseURL
        mockNetworkDecoder.error = MockNetworkDecoderError.test

        expect("Network client success request call") { description, expectation in
            let task = networkClient.request(
                method: .post,
                path: "",
                parameters: [:],
                object: Nil?.none,
                headers: [:]
            ) { (result: Result<TestModel, NetworkError>) -> Void in
                guard let error = SDAssertFailure(result, description, expectation) else { return }

                guard case NetworkError.decodeFailed(let decoderError) = error else {
                    XCTFail("Error from result should be decodeFailed")
                    expectation.fulfill()
                    return
                }

                guard case MockNetworkDecoderError.test = decoderError else {
                    XCTFail("urlBuildError should be MockNetworkDecoderError.test")
                    expectation.fulfill()
                    return
                }

                expectation.fulfill()
            }
            XCTAssertNotNil(task, description)
        }
    }
}
