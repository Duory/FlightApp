//
//  ThrottlerTests.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class ThrottlerTests: XCTestCase {
    private let timeInterval: TimeInterval = 1
    private let queue = DispatchQueue.main
    private var throttler: Throttler!

    override func setUp() {
        super.setUp()

        throttler = Throttler(timeInterval: timeInterval, queue: queue)
    }

    override func tearDown() {
        super.tearDown()

        throttler = nil
    }

    func testThrottlerFires() {
        expect("Throttler fires") { _, expectation in
            throttler.throttle {
                expectation.fulfill()
            }
        }
    }

    func testThrottlerCancels() {
        expect("Throttler cancels") { description, expectation in
            throttler.throttle {
                XCTFail(description)
            }
            throttler = nil
            queue.asyncAfter(deadline: .now() + timeInterval * 2) {
                expectation.fulfill()
            }
        }
    }

    func testThrottlerCancelAndThenFire() {
        expect("Throttler cancels and then fires") { description, expectation in
            throttler.throttle {
                XCTFail(description)
            }
            queue.asyncAfter(deadline: .now() + timeInterval / 2) {
                self.throttler.throttle {
                    expectation.fulfill()
                }
            }
        }
    }
}
