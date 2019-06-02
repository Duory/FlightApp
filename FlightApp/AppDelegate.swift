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
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        #if MOCK
        let appConfiguration = ApplicationConfigurator.Configuration.mock
        #elseif DEV
        let appConfiguration = ApplicationConfigurator.Configuration.dev
        #else
        fatalError("Unsupported configuration")
        #endif

        ApplicationAppearance().apply()
        let container = ApplicationConfigurator(configuration: appConfiguration).create()
        let applicationCoordinator = ApplicationCoordinator(window: window, container: container)
        applicationCoordinator.start()
        return true
    }
}
