//
//  UrlEncodedHttpSerializer.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

struct UrlEncodedHttpSerializer {
    typealias Value = [String: String]

    let contentType = "application/x-www-form-urlencoded"

    func serialize(_ value: Value) -> String {
        let result = value
            .map { name, value in
                UrlEncodedHttpSerializer.encode(name) + "=" + UrlEncodedHttpSerializer.encode("\(value)")
            }
            .joined(separator: "&")
        return result
    }

    func deserialize(_ string: String) -> Value {
        var params: Value = [:]
        let components = string.components(separatedBy: "&")
        components.forEach { param in
            let parts = param.components(separatedBy: "=")
            if parts.count == 2 {
                let name = UrlEncodedHttpSerializer.decode(parts[0])
                let value = UrlEncodedHttpSerializer.decode(parts[1])
                params[name] = value
            }
        }
        return params
    }

    private static var characters: CharacterSet = {
        var characters = CharacterSet.alphanumerics
        characters.insert(charactersIn: "-_.")
        return characters
    }()

    static func encode(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: characters) ?? ""
    }

    static func decode(_ string: String) -> String {
        return string.removingPercentEncoding ?? ""
    }
}
