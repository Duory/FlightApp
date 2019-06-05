//
//  Localization.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

enum Localization {
    enum Common {
        static let error = NSLocalizedString("common.error", comment: "")
        // swiftlint:disable:next identifier_name
        static let ok = NSLocalizedString("common.ok", comment: "")
    }

    enum AirportsSelection {
        static let from = NSLocalizedString("airports_selection.from", comment: "")
        static let to = NSLocalizedString("airports_selection.to", comment: "")
        static let buildRoute = NSLocalizedString("airports_selection.build_route", comment: "")
        static let search = NSLocalizedString("airports_selection.search", comment: "")
        static let searchPlaceholder = NSLocalizedString("airports_selection.search_placeholder", comment: "")
        static let anyAirport = NSLocalizedString("airports_selection.any_airport", comment: "")
    }

    enum DefaultAirport {
        static let name = NSLocalizedString("default_airport.name", comment: "")
        static let airportName = NSLocalizedString("default_airport.airport_name", comment: "")
        static let iata = NSLocalizedString("default_airport.iata", comment: "")
    }

    enum Map {
        static let flightRoute = NSLocalizedString("map.flight_route", comment: "")
    }
}
