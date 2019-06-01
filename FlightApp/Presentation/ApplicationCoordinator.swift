//
//  ApplicationCoordinator.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class ApplicationCoordinator {
    private let window: UIWindow
    private let container: DependencyInjectionContainer
    private var isRunningUnitTests: Bool {
        let env = ProcessInfo.processInfo.environment
        return env["XCTestConfigurationFilePath"] != nil
    }

    init(window: UIWindow, container: DependencyInjectionContainer) {
        self.window = window
        self.container = container
    }

    func start() {
        guard !isRunningUnitTests else { return }

        let airportsSelectionCoordinator = AirportsSelectionCoordinator { rootViewController in
            self.window.rootViewController = rootViewController
            self.window.makeKeyAndVisible()
        }
        airportsSelectionCoordinator.start()
    }
}
