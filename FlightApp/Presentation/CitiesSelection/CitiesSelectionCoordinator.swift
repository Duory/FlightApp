//
//  CitiesSelectionCoordinator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class CitiesSelectionCoordinator {
    private var onRootViewControllerCreated: (UIViewController) -> Void

    init(onRootViewControllerCreated: @escaping (UIViewController) -> Void) {
        self.onRootViewControllerCreated = onRootViewControllerCreated
    }

    func start() {
        showCitiesSelectionViewController()
    }

    private func showCitiesSelectionViewController() {
        onRootViewControllerCreated(citiesSelectionViewController())
    }

    private func citiesSelectionViewController() -> CitiesSelectionViewController {
        let viewController: CitiesSelectionViewController = Storyboard.citiesSelection.instantiate()
        return viewController
    }
}
