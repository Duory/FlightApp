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
        let startFromAirport: Airport?
        let startToAirport: Airport?
    }

    struct Actions {
        let searchAirport: (_ completion: @escaping (Airport?) -> Void) -> Void
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
        buildRouteButton.titleLabel?.font = Style.Font.regular
        buildRouteButton.setTitle(Localization.AirportsSelection.buildRoute, for: .normal)
        if let startFromAirport = data.startFromAirport {
            airportsSelectionView.updateFromAirport(startFromAirport)
        }
        if let startToAirport = data.startToAirport {
            airportsSelectionView.updateToAirport(startToAirport)
        }
        airportsSelectionView.onFromAirportPressed = { [weak self] in
            self?.searchFromAirport()
        }
        airportsSelectionView.onToAirportPressed = { [weak self] in
            self?.searchToAirport()
        }
    }

    private func searchFromAirport() {
        actions.searchAirport { [weak self] airport in
            if let airport = airport {
                self?.airportsSelectionView.updateFromAirport(airport)
            }
        }
    }

    private func searchToAirport() {
        actions.searchAirport { [weak self] airport in
            if let airport = airport {
                self?.airportsSelectionView.updateToAirport(airport)
            }
        }
    }
}
