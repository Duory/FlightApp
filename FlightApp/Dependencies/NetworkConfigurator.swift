//
//  NetworkConfigurator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class NetworkConfigurator: Configurator {
    private let endpointURL: URL

    init(endpointURL: URL) {
        self.endpointURL = endpointURL
    }

    func create() -> DependencyInjectionContainer {
        let container = Container()

        let networkClient = BaseNetworkClient(baseURL: endpointURL, completionQueue: .main)
        let airportService = BackendAirportService(networkClient: networkClient, locale: Locale.current.languageCode ?? "en")
        container.register { (object: inout AirportServiceDependency) in object.airportService = airportService }

        return container
    }
}
