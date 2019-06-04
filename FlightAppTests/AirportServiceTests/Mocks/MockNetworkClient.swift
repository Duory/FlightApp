//
//  MockNetworkClient.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class MockNetworkClient: LightNetworkClient {
    var result: Result<Airport, NetworkError>?
    var endpoint: Endpoint?
    var getCalled = false

    @discardableResult
    func get<ResponseObject: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<ResponseObject, NetworkError>) -> Void
    ) -> NetworkTask? {
        guard let result = result else { fatalError("result should be set for tests") }

        getCalled = true
        self.endpoint = endpoint
        DispatchQueue.main.async {
            switch result {
                case .success(let object):
                    guard let object = [ object ] as? ResponseObject else { fatalError("object should be set for tests") }

                    completion(.success(object))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        return MockNetworkTask()
    }
}
