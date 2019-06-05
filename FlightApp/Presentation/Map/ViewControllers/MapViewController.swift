//
//  MapViewController.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet private var mapContainer: UIView!
    @IBOutlet private var mapView: MKMapView!

    struct Actions {
        let dismiss: () -> Void
    }

    var actions: Actions!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        title = Localization.Map.flightRoute
        view.backgroundColor = Style.Color.airportsSelectionBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(callDismissAction)
        )
    }

    @objc private func callDismissAction() {
        actions.dismiss()
    }
}
