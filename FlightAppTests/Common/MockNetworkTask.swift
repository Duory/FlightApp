//
//  MockNetworkTask.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

struct MockNetworkTask: NetworkTask {
    func cancel() { }
}
