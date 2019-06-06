//
//  AirportAnnotationView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 06/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import MapKit

class AirportAnnotationView: MKAnnotationView {
    private enum Constants {
        static let width: CGFloat = 80
        static let height: CGFloat = 35
        static let borderWidth: CGFloat = 3
    }

    private let contentView = UIView()
    private let label = UILabel()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    private func setup() {
        contentView.backgroundColor = Style.Color.white.withAlphaComponent(0.75)
        contentView.layer.borderColor = Style.Color.blue.withAlphaComponent(0.75).cgColor
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.cornerRadius = Constants.height / 2
        label.font = Style.Font.medium(size: 18)
        label.textColor = Style.Color.blue.withAlphaComponent(0.75)
        label.textAlignment = .center
        addSubview(contentView)
        contentView.addSubview(label)
        contentView.frame = CGRect(x: 0, y: 0, width: Constants.width, height: Constants.height)
        contentView.center = center
        label.frame = contentView.bounds
    }

    func update(with airport: Airport) {
        label.text = airport.iata
    }
}
