//
//  NetworkEncoder.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

protocol NetworkEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}
