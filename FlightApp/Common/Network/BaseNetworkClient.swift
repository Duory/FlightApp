//
//  BaseNetworkClient.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class Task: NetworkTask {
    let urlSessionTask: URLSessionTask

    init(urlSessionTask: URLSessionTask) {
        self.urlSessionTask = urlSessionTask
    }

    func cancel() {
        urlSessionTask.cancel()
    }
}

class BaseNetworkClient: CodableNetworkClient {
    let baseURL: URL
    private let completionQueue: DispatchQueue

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    private let timeout: TimeInterval = 60
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout * 2
        configuration.urlCache = nil
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }()

    init(baseURL: URL, completionQueue: DispatchQueue) {
        self.baseURL = baseURL
        self.completionQueue = completionQueue
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
        let completion = completionInQueue(completion)
        let fullPath = "\(baseURL.absoluteString)/\(path)"
        guard let url = URL(string: fullPath)?.withParameters(parameters) else {
            completion(.failure(.badURL))
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.value
        headers.forEach { name, value in
            urlRequest.setValue(value, forHTTPHeaderField: name)
        }
        do {
            if let object = object {
                let body = try encoder.encode(object)
                urlRequest.httpBody = body
            }
        } catch {
            completion(.failure(.encodeFailed))
            return nil
        }

        let urlSessionTask = urlSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                return completion(.failure(.clientError(error)))
            }

            guard let response = urlResponse, let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(.noResponse))
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(.networkError(code: httpResponse.statusCode, response: response)))
            }

            guard let data = data else {
                return completion(.failure(.emptyData))
            }

            do {
                let object = try self.decoder.decode(ResponseObject.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.decodeFailed))
            }
        }
        urlSessionTask.resume()
        return Task(urlSessionTask: urlSessionTask)
    }

    private func completionInQueue<T>(_ completion: @escaping (T) -> Void) -> (T) -> Void {
        return { argument in
            self.completionQueue.async { completion(argument) }
        }
    }
}
