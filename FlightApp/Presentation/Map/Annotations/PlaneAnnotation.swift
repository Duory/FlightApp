//
//  PlaneAnnotation.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 06/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import MapKit

class PlaneAnnotation: NSObject, MKAnnotation {
    let planeImage: UIImage
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(planeImage: UIImage, coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
        self.planeImage = planeImage
        self.coordinate = coordinate
    }
}
