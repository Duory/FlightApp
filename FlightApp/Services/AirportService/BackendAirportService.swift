//
//  BackendAirportService.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class BackendAirportService: AirportService {
    private let networkClient: LightNetworkClient
    private let locale: String

    init(networkClient: LightNetworkClient, locale: String) {
        self.networkClient = networkClient
        self.locale = locale
    }

    func searchAirport(with name: String, completion: @escaping (Result<[Airport], Error>) -> Void) {
        networkClient.get(endpoint: Endpoint.places(term: name, locale: locale)) { (result: Result<[Airport], NetworkError>) -> Void in
            completion(result.mapError { $0 })
        }
    }
}
