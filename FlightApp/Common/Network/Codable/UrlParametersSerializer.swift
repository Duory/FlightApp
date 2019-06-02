//
//  UrlParametersSerializer.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

protocol UrlParametersSerializer {
    typealias Parameters = [String: String]

    func serialize(_ parameters: Parameters) -> String
    func deserialize(_ string: String) -> Parameters
}
