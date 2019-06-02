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
    private let http: Http
    private let urlRequestBuilder: URLRequestBuilder
    private let decoder: NetworkDecoder
    private let completionQueue: DispatchQueue

    init(baseURL: URL, http: Http, urlRequestBuilder: URLRequestBuilder, decoder: NetworkDecoder, completionQueue: DispatchQueue) {
        self.baseURL = baseURL
        self.http = http
        self.urlRequestBuilder = urlRequestBuilder
        self.decoder = decoder
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
        let urlRequest: URLRequest
        do {
            var builder = urlRequestBuilder
                .baseURL(baseURL)
                .path(path)
                .method(method)
                .parameters(parameters)
                .headers(headers)
            if let object = object {
                builder = builder.object(AnyEncodable(value: object))
            }
            urlRequest = try builder.build()
        } catch {
            completion(.failure(.urlBuild(error)))
            return nil
        }

        let urlSessionTask = http.dataTask(with: urlRequest) { [weak self] data, urlResponse, error in
            guard let self = self else { return }

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
                completion(.failure(.decodeFailed(error)))
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
