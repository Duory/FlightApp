//
//  Airport.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import CoreLocation

struct Airport: Decodable {
    struct Location: Decodable {
        let location: CLLocation

        init() {
            location = CLLocation(latitude: 0, longitude: 0)
        }

        init(from decoder: Decoder) throws {
            location = CLLocation(latitude: 0, longitude: 0)
        }
    }

    let location: Location
    let airportName: String?
    let name: String
    let iata: String
}
