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

    struct Actions {
        let searchAirport: (_ completion: (Result<Airport, Error>) -> Void) -> Void
    }

    var actions: Actions!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        view.backgroundColor = Style.Color.airportsSelectionBackground

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
                    airportsSelectionView.updateFromAirport(airport)
                case .failure(let error):
                    print(error)
            }
        }
    }

    private func searchToAirport() {
        actions.searchAirport { result in
            switch result {
                case .success(let airport):
                    airportsSelectionView.updateToAirport(airport)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
