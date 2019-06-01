//
//  CityButtonView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class CityButtonView: UIView {
    private let button = HighlightedButton()
    private let cityNameLabel = UILabel()
    private let airportNameLabel = UILabel()
    private let horizontalInset: CGFloat

    var onButtonPressed: (() -> Void)?

    init(horizontalInset: CGFloat = 0) {
        self.horizontalInset = horizontalInset
        super.init(frame: .zero)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        horizontalInset = 0
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.highlightedColor = Style.Color.highlight
        button.defaultColor = Style.Color.white
        button.addTarget(self, action: #selector(callButtonPressedAction), for: .touchUpInside)

        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.font = Style.Font.regular
        cityNameLabel.textColor = Style.Color.black
        cityNameLabel.textAlignment = .left

        airportNameLabel.translatesAutoresizingMaskIntoConstraints = false
        airportNameLabel.font = Style.Font.regular
        airportNameLabel.textColor = Style.Color.black
        airportNameLabel.textAlignment = .right

        addSubview(button)
        addSubview(cityNameLabel)
        addSubview(airportNameLabel)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalInset),
            cityNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            airportNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalInset),
            airportNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    @objc private func callButtonPressedAction() {
        onButtonPressed?()
    }

    func update(with airport: Airport) {
        cityNameLabel.text = airport.cityName
        airportNameLabel.text = airport.airportName
    }
}
