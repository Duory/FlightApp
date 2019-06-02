//
//  LightNetworkClient.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

protocol LightNetworkClient {
    @discardableResult
    func get<ResponseObject: Decodable>(
        endpoint: Endpoint,
        completion: @escaping (Result<ResponseObject, NetworkError>) -> Void
    ) -> NetworkTask?
}
