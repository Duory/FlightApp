//
//  UITableViewCell.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reusableIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
