//
//  NetworkClientTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class NetworkClientTests: XCTestCase {
    private let mockCodableNetworkClient = MockCodableNetworkClient(baseURL: TestConfiguration.baseURL)
    private var networkClient: LightNetworkClient!

    override func setUp() {
        super.setUp()

        networkClient = NetworkClient(networkClient: mockCodableNetworkClient)
    }

    override func tearDown() {
        super.tearDown()

        networkClient = nil
    }

    func testNetworkClientSuccessCall() {
        let successObject = TestModel(test: "test")
        mockCodableNetworkClient.result = .success(successObject)

        expect("Network client success call") { description, expectation in
            _ = networkClient.get(endpoint: Endpoint.places(term: "", locale: "")) { (result: Result<TestModel, NetworkError>) -> Void in
                guard
                    SDAssertTrue(self.mockCodableNetworkClient.requestCalled, description, expectation),
                    let object = SDAssertSuccess(result, description, expectation),
                    SDAssertEqual(object, successObject, description, expectation)
                else { return }

                expectation.fulfill()
            }
        }
    }

    func testNetworkClientReturnsError() {
        let failureError = NetworkError.emptyData
        mockCodableNetworkClient.result = .failure(failureError)

        expect("Network client success call") { description, expectation in
            _ = networkClient.get(endpoint: Endpoint.places(term: "", locale: "")) { (result: Result<TestModel, NetworkError>) -> Void in
                guard
                    SDAssertTrue(self.mockCodableNetworkClient.requestCalled, description, expectation),
                    let error = SDAssertFailure(result, description, expectation)
                else { return }

                guard case .emptyData = error else {
                    XCTFail("error should be emptyData")
                    expectation.fulfill()
                    return
                }

                expectation.fulfill()
            }
        }
    }
}
