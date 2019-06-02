//
//  JSONNetworkEncoder.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class JSONNetworkEncoder: NetworkEncoder {
    private let keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = keyEncodingStrategy
        return encoder
    }()

    init(keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy = .convertToSnakeCase) {
        self.keyEncodingStrategy = keyEncodingStrategy
    }

    func encode<T: Encodable>(_ value: T) throws -> Data {
        return try encoder.encode(value)
    }
}
