//
//  AirportCell.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportCell: UITableViewCell {
    @IBOutlet private var airportNameLabel: UILabel!
    @IBOutlet private var airportLocationLabel: UILabel!
    @IBOutlet private var iataLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    private func setup() {
        airportNameLabel.font = Style.Font.regular
        airportNameLabel.textColor = Style.Color.black
        airportLocationLabel.font = Style.Font.regular
        airportLocationLabel.textColor = Style.Color.lightGray
        iataLabel.font = Style.Font.regular
        iataLabel.textColor = Style.Color.black
    }

    func update(with airport: Airport) {
        airportNameLabel.text = airport.name
        airportLocationLabel.text = airport.airportName ?? Localization.AirportsSelection.anyAirport
        iataLabel.text = airport.iata
    }
}
