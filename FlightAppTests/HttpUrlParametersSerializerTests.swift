//
//  HttpUrlParametersSerializerTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class HttpUrlParametersSerializerTests: XCTestCase {
    private enum TestData {
        static let parameters = [ "term": "test term", "locale": "test locale" ]
        static let serializedString = "term=test%20term&locale=test%20locale"
        static let reversedSerializedString = "locale=test%20locale&term=test%20term"
    }

    private var serializer: UrlParametersSerializer!

    override func setUp() {
        super.setUp()

        serializer = HttpUrlParametersSerializer()
    }

    override func tearDown() {
        super.tearDown()

        serializer = nil
    }

    func testSerializerSerialize() {
        let serializedString = serializer.serialize(TestData.parameters)
        SDAssertTrue(
            serializedString == TestData.serializedString || serializedString == TestData.reversedSerializedString,
            "serializedString should be equal to expected string"
        )
    }

    func testSerializerDeserialize() {
        let parameters = serializer.deserialize(TestData.serializedString)
        SDAssertEqual(parameters, TestData.parameters, "parameters should be equal to expected parameters")
    }
}
