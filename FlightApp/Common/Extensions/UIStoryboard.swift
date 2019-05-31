//
//  UIStoryboard.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    func instantiateInitial<T: UIViewController>() -> T {
        guard let controller = instantiateInitialViewController() else {
            fatalError("Cannot instantiate initial view controller.")
        }

        guard let typedController = controller as? T else {
            fatalError("Cannot instantiate initial view controller. Expected type \(T.self), but received \(type(of: controller))")
        }

        return typedController
    }

    func instantiate<T: UIViewController>() -> T {
        return instantiate(id: String(describing: T.self))
    }

    func instantiate<T: UIViewController>(id: String) -> T {
        let controller = instantiateViewController(withIdentifier: id)

        guard let typedController = controller as? T else {
            fatalError("Cannot instantiate view controller with id \(id). Expected type \(T.self), but received \(type(of: controller))")
        }

        return typedController
    }
}
