//
//  AirportServiceTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import CoreLocation
import XCTest
@testable import FlightApp

extension Airport.Location: Equatable {
    public static func == (lhs: Airport.Location, rhs: Airport.Location) -> Bool {
        return lhs.location.coordinate.latitude == rhs.location.coordinate.latitude
            && lhs.location.coordinate.longitude == rhs.location.coordinate.longitude
    }

}

extension Airport: Equatable {
    public static func == (lhs: Airport, rhs: Airport) -> Bool {
        return lhs.location == rhs.location && lhs.airportName == rhs.airportName && lhs.name == rhs.name && lhs.iata == rhs.iata
    }
}

class AirportServiceTests: XCTestCase {
    private enum TestData {
        static let locale = "test locale"
    }

    private var mockNetworkClient = MockNetworkClient()
    private var airportService: AirportService!

    override func setUp() {
        super.setUp()

        airportService = BackendAirportService(networkClient: mockNetworkClient, locale: TestData.locale)
    }

    func testAirportServiceCallsGetWithRightEndpoint() {
        let expectedTerm = "term"
        let expectedAirport = Airport(
            location: Airport.Location(latitude: 0, longitude: 0),
            airportName: "test airport name",
            name: "test name",
            iata: "TEST"
        )
        mockNetworkClient.result = .success(expectedAirport)

        expect("AirportService calls get with right endpoint") { description, expectation in
            airportService.searchAirport(with: expectedTerm) { result in
                guard
                    SDAssertTrue(self.mockNetworkClient.getCalled, description, expectation),
                    let airport = SDAssertSuccess(result, description, expectation)?.first,
                    SDAssertEqual(airport, expectedAirport, description, expectation),
                    let endpoint = SDAssertNotNil(self.mockNetworkClient.endpoint, description, expectation)
                else { return }

                guard case .places(let term, let locale) = endpoint else {
                    XCTFail(description)
                    expectation.fulfill()
                    return
                }

                guard
                    SDAssertEqual(term, expectedTerm, description, expectation),
                    SDAssertEqual(locale, TestData.locale, description, expectation)
                else { return }

                expectation.fulfill()
            }
        }
    }

    func testAirportReturnsError() {
        mockNetworkClient.result = .failure(.emptyData)

        expect("AirportService returns error") { description, expectation in
            airportService.searchAirport(with: "") { result in
                guard let error = SDAssertFailure(result, description, expectation) else { return }

                guard
                    let networkError = error as? NetworkError,
                    case .emptyData = networkError
                else {
                    XCTFail(description)
                    expectation.fulfill()
                    return
                }

                expectation.fulfill()
            }
        }
    }
}
