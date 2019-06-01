//
//  AirportsSelectionCoordinator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportsSelectionCoordinator {
    private var onRootViewControllerCreated: (UIViewController) -> Void

    init(onRootViewControllerCreated: @escaping (UIViewController) -> Void) {
        self.onRootViewControllerCreated = onRootViewControllerCreated
    }

    func start() {
        showAirportsSelectionViewController()
    }

    private func showAirportsSelectionViewController() {
        onRootViewControllerCreated(airportsSelectionViewController())
    }

    private func airportsSelectionViewController() -> AirportsSelectionViewController {
        let viewController: AirportsSelectionViewController = Storyboard.airportsSelection.instantiate()
        return viewController
    }
}
