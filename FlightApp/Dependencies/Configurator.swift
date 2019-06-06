//
//  Configurator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 07/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

protocol Configurator {
    func create() -> DependencyInjectionContainer
}
