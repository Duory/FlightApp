//
//  ContainerTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

protocol TestService { }

protocol TestServiceDependency {
    var testService: TestService! { get set }
}

class TestServiceImplementation: TestService { }

class TestObject: TestServiceDependency {
    static var staticTestService: TestService!
    var testService: TestService!
}

class ContainerTests: XCTestCase {
    func testContainerResolvesVariable() {
        let container = Container()

        let testService = TestServiceImplementation()
        container.register { (object: inout TestServiceDependency) in object.testService = testService }

        let object = TestObject()
        container.resolve(object)

        SDAssertNotNil(object.testService, "TestService variable shouldn't be nil")
    }
}
