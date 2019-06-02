//
//  NetworkConfigurator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

class NetworkConfigurator: Configurator {
    private var userAgent = "FlightApp, iOS"
    private let contentType = "application/x-www-form-urlencoded"
    private let timeout: TimeInterval = 60
    private let endpointURL: URL

    init(endpointURL: URL) {
        self.endpointURL = endpointURL
    }

    func create() -> DependencyInjectionContainer {
        let container = Container()

        let urlRequestBuilder = NetworkURLRequestBuilder(
            serializer: HttpUrlParametersSerializer(),
            encoder: JSONNetworkEncoder(),
            userAgent: userAgent,
            contentType: contentType
        )
        let baseNetworkClient = BaseNetworkClient(
            baseURL: endpointURL,
            http: urlSession(),
            urlRequestBuilder: urlRequestBuilder,
            decoder: JSONNetworkDecoder(),
            completionQueue: .main
        )
        let networkClient = NetworkClient(networkClient: baseNetworkClient)
        let locale = Locale.current.languageCode ?? Locale.defaultLanguageCode
        let airportService = BackendAirportService(networkClient: networkClient, locale: locale)
        container.register { (object: inout AirportServiceDependency) in object.airportService = airportService }

        return container
    }

    private func urlSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout * 2
        configuration.urlCache = nil
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }
}
