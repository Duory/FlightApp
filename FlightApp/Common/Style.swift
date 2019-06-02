//
//  Style.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

enum Style {
    enum Color {
        static let clear = UIColor.clear
        static let black = UIColor.black
        static let white = UIColor.white
        static let lightGray = UIColor.lightGray
        static let orange = UIColor.fromRequired(hex: "F99A34")
        static let darkOrange = UIColor.fromRequired(hex: "CC8E52")

        static let airportsSelectionBackground = UIColor.fromRequired(hex: "00B3FF")
        static let navigationBarBackground = UIColor.fromRequired(hex: "00B3FF")
        static let separator = UIColor.lightGray
        static let highlight = UIColor.lightGray.withAlphaComponent(0.1)
        static let shadow = UIColor.black
    }

    enum Font {
        private static let defaultFontSize: CGFloat = 16

        static let regular = UIFont.systemFont(ofSize: defaultFontSize, weight: .regular)

        static func regular(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: .regular)
        }
    }
}
