//
//  Configurator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class ApplicationConfigurator: Configurator {
    enum Configuration {
        case dev
        case mock
    }

    private let configuration: Configuration

    private var endpointURL: String {
        switch configuration {
            case .dev:
                return "http://places.aviasales.ru"
            case .mock:
                return ""
        }
    }

    init(configuration: Configuration) {
        self.configuration = configuration
    }

    func create() -> DependencyInjectionContainer {
        switch configuration {
            case .dev:
                guard let url = URL(string: endpointURL) else { fatalError("Endpoint must be correct") }

                let configurator = NetworkConfigurator(endpointURL: url)
                return configurator.create()
            case .mock:
                let configurator = MockConfigurator()
                return configurator.create()
        }
    }
}
