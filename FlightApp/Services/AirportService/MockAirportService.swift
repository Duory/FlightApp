//
//  MockAirportService.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class MockAirportService: AirportService {
    private let answerDelay: TimeInterval = 1
    private let airports: [Airport] = [
        Airport(cityName: "1", airportName: "1", locationString: "1"),
        Airport(cityName: "1", airportName: "1", locationString: "1"),
        Airport(cityName: "1", airportName: "1", locationString: "1"),
        Airport(cityName: "1", airportName: "1", locationString: "1"),
    ]

    func searchAirport(with name: String, completion: @escaping (Result<[Airport], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + answerDelay) {
            completion(.success(self.airports))
        }
    }
}
