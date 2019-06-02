//
//  JSONNetworkDecoder.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class JSONNetworkDecoder: NetworkDecoder {
    private let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return decoder
    }()

    init(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) {
        self.keyDecodingStrategy = keyDecodingStrategy
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        return try decoder.decode(type, from: data)
    }
}
