//
//  URL.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

extension URL {
    func withParameters(_ parameters: [String: String]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return self }

        if !parameters.isEmpty {
            let serializer = UrlEncodedHttpSerializer()
            var queryParameters = serializer.deserialize(components.query ?? "")
            parameters.forEach { key, value in
                queryParameters[key] = value
            }
            components.percentEncodedQuery = serializer.serialize(queryParameters)
        }

        return components.url ?? self
    }
}
