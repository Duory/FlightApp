//
//  MockConfigurator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class MockConfigurator: Configurator {
    func create() -> DependencyInjectionContainer {
        let container = Container()

        let airportService = MockAirportService()
        container.register { (object: inout AirportServiceDependency) in object.airportService = airportService }

        return container
    }
}
