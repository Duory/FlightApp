//
//  AirportButtonView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportButtonView: UIView {
    private let button = HighlightedButton()
    private let placeholderView = UIView()
    private let placeholderLabel = UILabel()
    private let contentView = UIView()
    private let airportNameLabel = UILabel()
    private let iataLabel = UILabel()

    private let placeholder: String
    private let horizontalInset: CGFloat

    var onButtonPressed: (() -> Void)?

    init(placeholder: String, horizontalInset: CGFloat = 0) {
        self.placeholder = placeholder
        self.horizontalInset = horizontalInset
        super.init(frame: .zero)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        horizontalInset = 0
        placeholder = ""
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.backgroundColor = Style.Color.clear
        placeholderView.isUserInteractionEnabled = false
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.font = Style.Font.regular
        placeholderLabel.textColor = Style.Color.lightGray
        placeholderLabel.textAlignment = .left
        placeholderLabel.text = placeholder

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = Style.Color.clear
        contentView.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.highlightedColor = Style.Color.lightGray.withAlphaComponent(0.1)
        button.defaultColor = Style.Color.white
        button.addTarget(self, action: #selector(callButtonPressedAction), for: .touchUpInside)
        airportNameLabel.translatesAutoresizingMaskIntoConstraints = false
        airportNameLabel.font = Style.Font.regular
        airportNameLabel.textColor = Style.Color.black
        airportNameLabel.textAlignment = .left
        iataLabel.translatesAutoresizingMaskIntoConstraints = false
        iataLabel.font = Style.Font.regular
        iataLabel.textColor = Style.Color.black
        iataLabel.textAlignment = .right
        iataLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        placeholderView.isHidden = false
        contentView.isHidden = true

        addSubview(button)
        addSubview(placeholderView)
        placeholderView.addSubview(placeholderLabel)
        addSubview(contentView)
        contentView.addSubview(airportNameLabel)
        contentView.addSubview(iataLabel)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeholderView.topAnchor.constraint(equalTo: topAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: placeholderView.centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: horizontalInset),
            placeholderLabel.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor, constant: -horizontalInset),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            airportNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            airportNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            airportNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: iataLabel.leadingAnchor, constant: -8),
            iataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset),
            iataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    @objc private func callButtonPressedAction() {
        onButtonPressed?()
    }

    func update(with airport: Airport) {
        placeholderView.isHidden = true
        contentView.isHidden = false
        airportNameLabel.text = airport.name
        iataLabel.text = airport.iata
    }
}
