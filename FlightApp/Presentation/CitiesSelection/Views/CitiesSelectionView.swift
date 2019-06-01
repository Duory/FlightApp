//
//  CitiesSelectionView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class CitiesSelectionView: UIView {
    private enum Constants {
        static let leadingOffset: CGFloat = 40
        static let buttonHeight: CGFloat = 60
        static let separatorHeight: CGFloat = 0.5
    }

    private let stackView = UIStackView()
    private let fromCityButton = CityButtonView(horizontalInset: Constants.leadingOffset)
    private let separatorView = UIView()
    private let toCityButton = CityButtonView(horizontalInset: Constants.leadingOffset)

    var onFromCityPressed: (() -> Void)?
    var onToCityPressed: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        layer.masksToBounds = true
        layer.cornerRadius = 8

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center

        fromCityButton.translatesAutoresizingMaskIntoConstraints = false
        fromCityButton.update(with: Airport(cityName: "From City", airportName: "FRM"))
        fromCityButton.onButtonPressed = { [weak self] in
            self?.onFromCityPressed?()
        }

        toCityButton.translatesAutoresizingMaskIntoConstraints = false
        toCityButton.update(with: Airport(cityName: "To City", airportName: "TO"))
        toCityButton.onButtonPressed = { [weak self] in
            self?.onToCityPressed?()
        }

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Style.Color.separator

        addSubview(stackView)
        stackView.addArrangedSubview(fromCityButton)
        stackView.addArrangedSubview(separatorView)
        stackView.addArrangedSubview(toCityButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fromCityButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            fromCityButton.widthAnchor.constraint(equalTo: widthAnchor),
            toCityButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            toCityButton.widthAnchor.constraint(equalTo: widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight),
            separatorView.widthAnchor.constraint(equalTo: widthAnchor, constant: -Constants.leadingOffset * 2)
        ])
    }
}
