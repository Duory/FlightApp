//
//  CodableNetworkClient.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

enum HttpMethod {
    case get
    case post
    case put
    case patch
    case delete

    var value: String {
        switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .patch: return "PATCH"
            case .delete: return "DELETE"
        }
    }
}

enum NetworkError: Error {
    case badURL
    case noResponse
    case emptyData
    case clientError(Error)
    case networkError(code: Int, response: URLResponse)
    case encodeFailed
    case decodeFailed
}

protocol NetworkTask {
    func cancel()
}

struct Nil: Codable { }

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

extension CodableNetworkClient {
    @discardableResult
    func get<ResponseObject: Decodable>(
        path: String,
        parameters: [String: String],
        completion: @escaping (Result<ResponseObject, NetworkError>) -> Void
    ) -> NetworkTask? {
        return request(method: .get, path: path, parameters: parameters, object: Nil?.none, headers: [:], completion: completion)
    }
}
