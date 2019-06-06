//
//  AirportsSelectionView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportsSelectionView: UIView {
    private enum Constants {
        static let leadingOffset: CGFloat = 40
        static let buttonHeight: CGFloat = 60
        static let separatorHeight: CGFloat = 0.5
    }

    private let stackView = UIStackView()
    private let separatorView = UIView()
    private let fromAirportView = AirportButtonView(
        placeholder: Localization.AirportsSelection.from,
        horizontalInset: Constants.leadingOffset
    )
    private let toAirportView = AirportButtonView(
        placeholder: Localization.AirportsSelection.to,
        horizontalInset: Constants.leadingOffset
    )

    var onFromAirportPressed: (() -> Void)?
    var onToAirportPressed: (() -> Void)?

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
        fromAirportView.translatesAutoresizingMaskIntoConstraints = false
        fromAirportView.onButtonPressed = { [weak self] in
            self?.onFromAirportPressed?()
        }
        toAirportView.translatesAutoresizingMaskIntoConstraints = false
        toAirportView.onButtonPressed = { [weak self] in
            self?.onToAirportPressed?()
        }
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Style.Color.lightGray

        addSubview(stackView)
        stackView.addArrangedSubview(fromAirportView)
        stackView.addArrangedSubview(separatorView)
        stackView.addArrangedSubview(toAirportView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fromAirportView.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            fromAirportView.widthAnchor.constraint(equalTo: widthAnchor),
            toAirportView.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            toAirportView.widthAnchor.constraint(equalTo: widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight),
            separatorView.widthAnchor.constraint(equalTo: widthAnchor, constant: -Constants.leadingOffset * 2)
        ])
    }

    func updateFromAirport(_ airport: Airport) {
        fromAirportView.update(with: airport)
    }

    func updateToAirport(_ airport: Airport) {
        toAirportView.update(with: airport)
    }
}
