//
//  MKAnnotationView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 06/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation
import MapKit

extension MKAnnotationView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
