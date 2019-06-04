//
//  MockNetworkDecoder.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

enum MockNetworkDecoderError: Error {
    case test
}

class MockNetworkDecoder: NetworkDecoder {
    var object: TestModel?
    var error: Error?
    var decodeCalled = false

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        if let error = error { throw error }
        guard let object = object as? T else { fatalError("Object should be set for test") }

        decodeCalled = true
        return object
    }
}
