//
//  JSONNetworkEncoderTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 05/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class JSONNetworkEncoderTests: XCTestCase {
    private var networkEncoder: NetworkEncoder!

    override func setUp() {
        super.setUp()

        networkEncoder = JSONNetworkEncoder()
    }

    override func tearDown() {
        super.tearDown()

        networkEncoder = nil
    }

    func testNetworkEncoderEncode() {
        do {
            let testModel = TestModel(testName: "test")
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let expectedData = try encoder.encode(testModel)
            let data = try networkEncoder.encode(testModel)
            SDAssertEqual(data, expectedData, "Encoded data should be equal to expected data")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
