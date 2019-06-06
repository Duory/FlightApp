//
//  AirportAnnotation.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 06/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation
import MapKit

class AirportAnnotation: NSObject, MKAnnotation {
    let airport: Airport
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(airport: Airport) {
        self.airport = airport
        coordinate = airport.location.location.coordinate
        super.init()
    }
}
