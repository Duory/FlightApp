//
//  TestConfigurator.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class TestConfigurator: Configurator {
    // swiftlint:disable:next force_unwrapping
    let baseURL = URL(string: "http://places.aviasales.ru")!

    func create() -> DependencyInjectionContainer {
        let container = Container()
        return container
    }
}
