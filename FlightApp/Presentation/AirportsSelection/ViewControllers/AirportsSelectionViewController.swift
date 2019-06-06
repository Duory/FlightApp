//
//  AirportsSelectionViewController.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportsSelectionViewController: BaseViewController {
    @IBOutlet private var airportsSelectionView: AirportsSelectionView!
    @IBOutlet private var buildRouteButton: RoundedShadowButton!

    struct Data {
        let startFromAirport: Airport?
        let startToAirport: Airport?
    }

    struct Actions {
        let searchAirport: (_ completion: @escaping (Airport?) -> Void) -> Void
        let buildRoute: (_ fromAirport: Airport, _ toAirport: Airport) -> Void
    }

    var data: Data!
    var actions: Actions!

    private var fromAirport: Airport?
    private var toAirport: Airport?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        view.backgroundColor = Style.Color.blue
        buildRouteButton.backgroundColor = Style.Color.orange
        buildRouteButton.defaultColor = Style.Color.orange
        buildRouteButton.highlightedColor = Style.Color.darkOrange
        buildRouteButton.titleLabel?.font = Style.Font.regular
        buildRouteButton.setTitle(Localization.AirportsSelection.buildRoute, for: .normal)
        if let startFromAirport = data.startFromAirport {
            fromAirport = startFromAirport
            airportsSelectionView.updateFromAirport(startFromAirport)
        }
        if let startToAirport = data.startToAirport {
            toAirport = startToAirport
            airportsSelectionView.updateToAirport(startToAirport)
        }
        airportsSelectionView.onFromAirportPressed = { [weak self] in
            self?.searchFromAirport()
        }
        airportsSelectionView.onToAirportPressed = { [weak self] in
            self?.searchToAirport()
        }
        updateBuildRouteButton()
    }

    private func searchFromAirport() {
        actions.searchAirport { [weak self] airport in
            guard let self = self else { return }

            if let airport = airport {
                self.fromAirport = airport
                self.airportsSelectionView.updateFromAirport(airport)
                self.updateBuildRouteButton()
            }
        }
    }

    private func searchToAirport() {
        actions.searchAirport { [weak self] airport in
            guard let self = self else { return }

            if let airport = airport {
                self.toAirport = airport
                self.airportsSelectionView.updateToAirport(airport)
                self.updateBuildRouteButton()
            }
        }
    }

    private func updateBuildRouteButton() {
        guard let fromAirport = fromAirport, let toAirport = toAirport else {
            buildRouteButton.isEnabled = false
            return
        }

        buildRouteButton.isEnabled = fromAirport != toAirport
    }

    @IBAction private func callBuildRouteAction() {
        guard let fromAirport = fromAirport, let toAirport = toAirport else { return }

        actions.buildRoute(fromAirport, toAirport)
    }
}
