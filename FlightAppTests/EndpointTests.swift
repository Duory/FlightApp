//
//  EndpointTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class EndpointTests: XCTestCase {
    func testPlacesEndpoint() {
        let term = "test term"
        let locale = "test locale"
        let expectedPath = "places"
        let expectedParameters = [ "term": term, "locale": locale ]

        let endpoint = Endpoint.places(term: term, locale: locale)
        XCTAssertEqual(endpoint.path, expectedPath)
        XCTAssertEqual(endpoint.parameters, expectedParameters)
    }
}
