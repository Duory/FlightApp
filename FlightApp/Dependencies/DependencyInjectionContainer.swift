//
//  DependencyInjectionContainer.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

public protocol DependencyInjectionContainer {
    func resolve(_ object: Any?)
}
