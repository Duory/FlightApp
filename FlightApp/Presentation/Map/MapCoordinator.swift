//
//  MapCoordinator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class MapCoordinator {
    private let rootViewController: UIViewController
    private let fromAirport: Airport
    private let toAirport: Airport

    init(rootViewController: UIViewController, fromAirport: Airport, toAirport: Airport) {
        self.rootViewController = rootViewController
        self.fromAirport = fromAirport
        self.toAirport = toAirport
    }

    func start() {
        showMapViewController(from: rootViewController)
    }

    func showMapViewController(from rootViewController: UIViewController) {
        let viewController = createMapViewController()
        let navigationController = CustomNavigationController(rootViewController: viewController)
        rootViewController.present(navigationController, animated: true, completion: nil)
    }

    func createMapViewController() -> MapViewController {
        let viewController: MapViewController = Storyboard.map.instantiate()
        viewController.data = .init(
            fromAirport: fromAirport,
            toAirport: toAirport
        )
        viewController.actions = .init(
            dismiss: {
                self.rootViewController.dismiss(animated: true, completion: nil)
            }
        )
        return viewController
    }
}
