//
//  AirportCell.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportCell: UITableViewCell {
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var airportLocationLabel: UILabel!
    @IBOutlet private var airportNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    private func setup() {
        cityNameLabel.font = Style.Font.regular
        cityNameLabel.textColor = Style.Color.black
        airportLocationLabel.font = Style.Font.regular
        airportLocationLabel.textColor = Style.Color.lightGray
        airportNameLabel.font = Style.Font.regular
        airportNameLabel.textColor = Style.Color.black
    }
}
