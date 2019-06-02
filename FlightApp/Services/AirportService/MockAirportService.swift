//
//  MockAirportService.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class MockAirportService: AirportService {
    enum MockAirportServiceError: Error {
        case emptyResult
    }

    private enum AnswerType {
        static let searchAirportAnswerType: SearchAirportAnswerType = .empty
    }

    private enum SearchAirportAnswerType {
        case success
        case empty
        case error
    }

    private let answerDelay: TimeInterval = 1

    func searchAirport(with name: String, completion: @escaping (Result<[Airport], Error>) -> Void) {
        let airports: [Airport] = (0 ..< 20).map {
            Airport(location: Airport.Location(), airportName: "\($0)", name: "\($0)", iata: "\($0)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + answerDelay) {
            switch AnswerType.searchAirportAnswerType {
                case .success:
                    completion(.success(airports))
                case .empty:
                    completion(.success([]))
                case .error:
                    completion(.failure(MockAirportServiceError.emptyResult))
            }
        }
    }
}
