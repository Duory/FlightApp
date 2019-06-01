//
//  UITableView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 01/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T {
            return cell
        }
        return T()
    }
}
