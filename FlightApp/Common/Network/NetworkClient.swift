//
//  NetworkClient.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class NetworkClient: LightNetworkClient {
    private struct Nil: Codable { }

    private let networkClient: CodableNetworkClient

    init(networkClient: CodableNetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func get<ResponseObject: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<ResponseObject, NetworkError>) -> Void
    ) -> NetworkTask? {
        return networkClient.request(
            method: .get,
            path: endpoint.path,
            parameters: endpoint.parameters,
            object: Nil?.none,
            headers: [:],
            completion: completion
        )
    }
}
