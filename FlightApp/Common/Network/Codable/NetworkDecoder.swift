//
//  NetworkDecoder.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

protocol NetworkDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}
