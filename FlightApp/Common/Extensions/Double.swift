//
//  Double.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 07/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

extension Double {
    var radians: Double {
        return self * .pi / 180
    }

    var degrees: Double {
        return self * 180 / .pi
    }
}
