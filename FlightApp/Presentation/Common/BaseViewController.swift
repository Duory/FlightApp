//
//  BaseViewController.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    func handle(error: Error) {
        let alertController = UIAlertController(
            title: Localization.Common.error,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Localization.Common.ok, style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
