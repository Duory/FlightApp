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
        static let blue = UIColor.fromRequired(hex: "00B3FF")
    }

    enum Font {
        private static let defaultFontSize: CGFloat = 16

        static let regular = UIFont.systemFont(ofSize: defaultFontSize, weight: .regular)
        static let medium = UIFont.systemFont(ofSize: defaultFontSize, weight: .medium)

        static func regular(size: CGFloat) -> UIFont {
            return regular.withSize(size)
        }

        static func medium(size: CGFloat) -> UIFont {
            return medium.withSize(size)
        }
    }
}
