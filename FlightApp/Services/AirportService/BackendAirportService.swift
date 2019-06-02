//
//  BackendAirportService.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class BackendAirportService: AirportService {
    private let networkClient: CodableNetworkClient
    private let locale: String

    init(networkClient: CodableNetworkClient, locale: String) {
        self.networkClient = networkClient
        self.locale = locale
    }

    func searchAirport(with name: String, completion: @escaping (Result<[Airport], Error>) -> Void) {
        networkClient.get(
            path: "places",
            parameters: [ "term": name, "locale": locale ]
        ) { (result: Result<[Airport], NetworkError>) -> Void in
            completion(result.mapError { $0 })
        }
    }
}
