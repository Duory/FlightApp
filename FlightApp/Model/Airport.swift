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
        private enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }

        let location: CLLocation

        init(latitude: Double, longitude: Double) {
            location = CLLocation(latitude: latitude, longitude: longitude)
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let latitude = try container.decode(Double.self, forKey: .latitude)
            let longitude = try container.decode(Double.self, forKey: .longitude)
            location = CLLocation(latitude: latitude, longitude: longitude)
        }
    }

    let location: Location
    let airportName: String?
    let name: String
    let iata: String
}
