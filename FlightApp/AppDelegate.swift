//
//  AppDelegate.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appearance: ApplicationAppearance = ApplicationAppearance()
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        appearance.apply()

        let container = Configurator().createContainer()
        let applicationCoordinator = ApplicationCoordinator(window: window, container: container)
        applicationCoordinator.start()
        return true
    }
}
