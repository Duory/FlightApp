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
    private var mapViewController: MapViewController?

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func start() {
        showMapViewController(from: rootViewController)
    }

    func showMapViewController(from rootViewController: UIViewController) {
        let viewController = createMapViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        rootViewController.present(navigationController, animated: true, completion: nil)
    }

    func createMapViewController() -> MapViewController {
        let viewController: MapViewController = Storyboard.map.instantiate()
        viewController.actions = .init(
            dismiss: {
                self.rootViewController.dismiss(animated: true, completion: nil)
            }
        )
        return viewController
    }
}
