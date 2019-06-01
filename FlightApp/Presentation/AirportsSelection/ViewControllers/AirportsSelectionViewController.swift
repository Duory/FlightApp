//
//  AirportsSelectionViewController.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportsSelectionViewController: UIViewController {
    @IBOutlet private var airportsSelectionView: AirportsSelectionView!
    @IBOutlet private var buildRouteButton: RoundedShadowButton!

    struct Data {
        let startFromAirport: Airport
        let startToAirport: Airport
    }

    struct Actions {
        let searchAirport: (_ completion: (Result<Airport?, Error>) -> Void) -> Void
    }

    var data: Data!
    var actions: Actions!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        view.backgroundColor = Style.Color.airportsSelectionBackground

        buildRouteButton.backgroundColor = Style.Color.orange
        buildRouteButton.defaultColor = Style.Color.orange
        buildRouteButton.highlightedColor = Style.Color.darkOrange

        airportsSelectionView.updateFromAirport(data.startFromAirport)
        airportsSelectionView.updateToAirport(data.startToAirport)

        airportsSelectionView.onFromAirportPressed = { [weak self] in
            self?.searchFromAirport()
        }
        airportsSelectionView.onToAirportPressed = { [weak self] in
            self?.searchToAirport()
        }
    }

    private func searchFromAirport() {
        actions.searchAirport { result in
            switch result {
                case .success(let airport):
                    if let airport = airport {
                        airportsSelectionView.updateFromAirport(airport)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }

    private func searchToAirport() {
        actions.searchAirport { result in
            switch result {
                case .success(let airport):
                    if let airport = airport {
                        airportsSelectionView.updateToAirport(airport)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
