//
//  AirportsSelectionCoordinator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportsSelectionCoordinator: AirportServiceDependency {
    private var onRootViewControllerCreated: (UIViewController) -> Void
    private weak var navigationController: UINavigationController?

    var airportService: AirportService!

    init(onRootViewControllerCreated: @escaping (UIViewController) -> Void) {
        self.onRootViewControllerCreated = onRootViewControllerCreated
    }

    func start() {
        showAirportsSelectionViewController()
    }

    private func showAirportsSelectionViewController() {
        let viewController = createAirportsSelectionViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        onRootViewControllerCreated(navigationController)
    }

    private func createAirportsSelectionViewController() -> AirportsSelectionViewController {
        let viewController: AirportsSelectionViewController = Storyboard.airportsSelection.instantiate()
        viewController.data = .init(
            startFromAirport: nil,
            startToAirport: nil
        )
        viewController.actions = .init(
            searchAirport: { completion in
                self.showAirportSearchViewController(searchAirportCompletion: completion)
            }
        )
        return viewController
    }

    private func showAirportSearchViewController(searchAirportCompletion: @escaping (Airport?) -> Void) {
        guard let navigationController = navigationController else { return }

        let viewController = createAirportSearchViewController(searchAirportCompletion: searchAirportCompletion)
        navigationController.pushViewController(viewController, animated: true)
    }

    private func createAirportSearchViewController(
        searchAirportCompletion: @escaping (Airport?) -> Void
    ) -> AirportSearchViewController {
        let viewController: AirportSearchViewController = Storyboard.airportsSelection.instantiate()
        viewController.actions = .init(
            search: { airportName, completion in
                self.airportService.searchAirport(with: airportName, completion: completion)
            },
            selectAirport: { selectedAirport in
                searchAirportCompletion(selectedAirport)
                self.navigationController?.popViewController(animated: true)
            }
        )
        return viewController
    }
}
