//
//  Container.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class Container: DependencyInjectionContainer {
    typealias Resolver = (Any) -> Void

    private var resolvers: [Resolver] = []

    func register(_ resolver: @escaping Resolver) {
        resolvers.append(resolver)
    }

    func register<D>(_ resolver: @escaping (inout D) -> Void) {
        register { object in
            guard var object = object as? D else { return }

            resolver(&object)
        }
    }

    func resolve(_ object: Any?) {
        guard let object = object else { return }

        resolvers.forEach { resolver in
            resolver(object)
        }
    }
}
