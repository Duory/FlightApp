//
//  ApplicationAppearance.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class ApplicationAppearance {
    func apply() {
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBar.appearance()
        appearance.shadowImage = UIImage()
        appearance.tintColor = Style.Color.white
        appearance.setBackgroundImage(UIImage(), for: .default)
    }
}
