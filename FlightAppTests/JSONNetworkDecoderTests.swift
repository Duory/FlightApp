//
//  JSONNetworkDecoderTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 05/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class JSONNetworkDecoderTests: XCTestCase {
    private var networkDecoder: NetworkDecoder!

    override func setUp() {
        super.setUp()

        networkDecoder = JSONNetworkDecoder()
    }

    override func tearDown() {
        super.tearDown()

        networkDecoder = nil
    }

    func testNetworkDecoderDecode() {
        do {
            let expectedTestModel = TestModel(testName: "test")
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(expectedTestModel)
            let testModel = try networkDecoder.decode(TestModel.self, from: data)
            SDAssertEqual(testModel, expectedTestModel, "Encoded data should be equal to expected data")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
