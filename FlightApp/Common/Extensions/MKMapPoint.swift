//
//  MKMapPoint.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 07/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import MapKit

extension MKMapPoint {
    var cgPoint: CGPoint {
        return CGPoint(x: x, y: y)
    }
}
