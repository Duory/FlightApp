//
//  CodableNetworkClient.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case urlBuild(Error)
    case noResponse
    case emptyData
    case clientError(Error)
    case networkError(code: Int, response: URLResponse)
    case decodeFailed(Error)
}

protocol NetworkTask {
    func cancel()
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol CodableNetworkClient {
    var baseURL: URL { get }

    @discardableResult
    func request<RequestObject: Encodable, ResponseObject: Decodable>(
        method: HttpMethod,
        path: String,
        parameters: [String: String],
        object: RequestObject?,
        headers: [String: String],
        completion: @escaping (Result<ResponseObject, NetworkError>) -> Void
    ) -> NetworkTask?
}
