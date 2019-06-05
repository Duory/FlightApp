//
//  URLRequestBuilder.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

struct AnyEncodable: Encodable {
    let value: Encodable

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

enum NetworkURLRequestBuilderError: Error {
    case baseURLIsNil
    case pathIsNil
    case httpMethodIsNil
    case badURL(String)
    case objectShouldBeEncodable
}

protocol URLRequestBuilder {
    func baseURL(_ newBaseURL: URL) -> URLRequestBuilder
    func path(_ newPath: String) -> URLRequestBuilder
    func method(_ newMethod: HttpMethod) -> URLRequestBuilder
    func parameters(_ newParameters: [String: String]) -> URLRequestBuilder
    func object(_ newObject: AnyEncodable) -> URLRequestBuilder
    func headers(_ newHeaders: [String: String]) -> URLRequestBuilder
    func build() throws -> URLRequest
}
