//
//  Endpoints.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

enum Endpoint {
    case places(term: String, locale: String)

    var path: String {
        switch self {
            case .places:
                return "places"
        }
    }

    var parameters: [String: String] {
        switch self {
            case .places(let term, let locale):
                return [ "term": term, "locale": locale ]
        }
    }
}
