//
//  HttpUrlParametersSerializer.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

struct HttpUrlParametersSerializer: UrlParametersSerializer {
    private var characters: CharacterSet = {
        var characters = CharacterSet.alphanumerics
        characters.insert(charactersIn: "-_.")
        return characters
    }()

    func serialize(_ parameters: Parameters) -> String {
        let result = parameters
            .map { name, value in
                encode(name) + "=" + encode("\(value)")
            }
            .joined(separator: "&")
        return result
    }

    func deserialize(_ string: String) -> Parameters {
        var parameters: Parameters = [:]
        let components = string.components(separatedBy: "&")
        components.forEach { component in
            let parts = component.components(separatedBy: "=")
            if parts.count == 2 {
                let name = decode(parts[0])
                let value = decode(parts[1])
                parameters[name] = value
            }
        }
        return parameters
    }

    private func encode(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: characters) ?? ""
    }

    private func decode(_ string: String) -> String {
        return string.removingPercentEncoding ?? ""
    }
}
