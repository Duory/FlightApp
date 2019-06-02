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
        setupSearchBar()
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBar.appearance()
        appearance.shadowImage = UIImage()
        appearance.tintColor = Style.Color.white
        appearance.setBackgroundImage(UIImage(), for: .default)
        appearance.titleTextAttributes = [ .foregroundColor: Style.Color.white, .font: Style.Font.regular(size: 18) ]
    }

    private func setupSearchBar() {
        let appearance = UISearchBar.appearance()
        appearance.barTintColor = Style.Color.white
        appearance.backgroundImage = UIImage()

        let cancelButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [ UISearchBar.self ])
        cancelButtonAppearance.setTitleTextAttributes([ .foregroundColor: Style.Color.white], for: .normal)
    }
}
