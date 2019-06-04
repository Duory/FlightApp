//
//  MockCodableNetworkClient.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class MockCodableNetworkClient: CodableNetworkClient {
    var baseURL: URL
    var result: Result<TestModel, NetworkError>?
    var requestCalled = false

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    @discardableResult
    func request<RequestObject: Encodable, ResponseObject: Decodable>(
        method: HttpMethod,
        path: String,
        parameters: [String: String],
        object: RequestObject?,
        headers: [String: String],
        completion: @escaping (Result<ResponseObject, NetworkError>) -> Void
    ) -> NetworkTask? {
        guard let result = result else { fatalError("object should be set for tests") }

        requestCalled = true
        DispatchQueue.main.async {
            switch result {
                case .success(let object):
                    guard let object = object as? ResponseObject else { fatalError("object should be set for tests") }

                    completion(.success(object))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        return MockNetworkTask()
    }
}
