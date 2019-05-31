//
//  UIColor.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

extension UIColor {
    static func fromRequired(hex: String) -> UIColor {
        guard let color = from(hex: hex) else { fatalError("Cannot create a color from hex string: \(hex)") }
        return color
    }

    static func from(hex: String) -> UIColor? {
        guard !hex.isEmpty else { return nil }

        var string = hex.uppercased()
        if string[string.startIndex] == "#" {
            string.remove(at: string.startIndex)
        }

        guard hex.count >= 3 else { return nil }
        guard let rgb = UInt32(string, radix: 16) else { return nil }

        let alpha, red, green, blue: UInt32
        switch string.count {
            case 3:
                (alpha, red, green, blue) = (255, (rgb >> 8 & 0xF) * 17, (rgb >> 4 & 0xF) * 17, (rgb & 0xF) * 17)
            case 4:
                (alpha, red, green, blue) = ((rgb >> 12 & 0xF) * 17, (rgb >> 8 & 0xF) * 17, (rgb >> 4 & 0xF) * 17, (rgb & 0xF) * 17)
            case 6:
                (alpha, red, green, blue) = (255, rgb >> 16, rgb >> 8 & 0xFF, rgb & 0xFF)
            case 8:
                (alpha, red, green, blue) = (rgb >> 24, rgb >> 16 & 0xFF, rgb >> 8 & 0xFF, rgb & 0xFF)
            default:
                return nil
        }

        return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
}
