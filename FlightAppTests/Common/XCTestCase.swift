//
//  XCTestCase.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

extension XCTestCase {
    typealias ExpectationHandler = (_ desctiption: String, _ expectation: XCTestExpectation) -> Void

    func expect(
        _ description: String,
        timeout: TimeInterval = 30,
        file: StaticString = #file,
        line: UInt = #line,
        handler: ExpectationHandler
    ) {
        let asyncExpectation = expectation(description: description)
        handler(description, asyncExpectation)
        waitForExpectations(timeout: timeout) { error in
            SDAssertNotError(error, description, file: file, line: line)
        }
    }
}

@discardableResult
func SDAssertError(_ error: Error?, _ description: String, file: StaticString = #file, line: UInt = #line) -> Bool {
    XCTAssertNotNil(error, "\(description): error expected.", file: file, line: line)
    return error != nil
}

@discardableResult
func SDAssertNotError(_ error: Error?, _ description: String, file: StaticString = #file, line: UInt = #line) -> Bool {
    let errorDescription = error.map(errorDebugDescription) ?? "nil"
    XCTAssertNil(error, "\(description): error: " + errorDescription, file: file, line: line)
    return error == nil
}

@discardableResult
func SDAssertNotNil<T>(
    _ value: T?,
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> T? {
    if value == nil {
        XCTFail("\(description): non nil value expected.", file: file, line: line)
        expectation?.fulfill()
    }
    return value
}

@discardableResult
func SDAssertNotError(
    _ error: Error?,
    _ description: String,
    _ expectation: XCTestExpectation?,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if let error = error {
        XCTFail("\(description): no error expected, but got: \(errorDebugDescription(error))", file: file, line: line)
        expectation?.fulfill()
    }
    return error == nil
}

@discardableResult
func SDAssertError(
    _ error: Error?,
    _ description: String,
    _ expectation: XCTestExpectation?,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if error == nil {
        XCTFail("\(description): error expected", file: file, line: line)
        expectation?.fulfill()
    }
    return error != nil
}

@discardableResult
func SDAssertSuccess<T, E>(
    _ result: Result<T, E>,
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> T? {
    switch result {
        case .success(let value):
            return value
        case .failure(let error):
            XCTFail("\(description): success expected, but got: \(errorDebugDescription(error))", file: file, line: line)
            expectation?.fulfill()
            return nil
    }
}

@discardableResult
func SDAssertFailure<T, E>(
    _ result: Result<T, E>,
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> E? {
    switch result {
        case .success:
            XCTFail("\(description): failure expected", file: file, line: line)
            expectation?.fulfill()
            return nil
        case .failure(let error):
            return error
    }
}

func SDFail(_ description: String, _ expectation: XCTestExpectation? = nil, file: StaticString = #file, line: UInt = #line) {
    XCTFail("\(description): failure expected", file: file, line: line)
    expectation?.fulfill()
}

@discardableResult
func SDAssertEqual<T: Equatable>(
    _ lhs: T?,
    _ rhs: T?,
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if lhs != rhs {
        XCTFail("\(description): lhs not equal to rhs", file: file, line: line)
        expectation?.fulfill()
    }
    return lhs == rhs
}

@discardableResult
func SDAssertNotEqual<T: Equatable>(
    _ lhs: T?,
    _ rhs: T?,
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if lhs == rhs {
        XCTFail("\(description): lhs equal to rhs", file: file, line: line)
        expectation?.fulfill()
    }
    return lhs != rhs
}

@discardableResult
func SDAssertTrue(
    _ value: Bool,
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if !value {
        XCTFail("\(description): true expected", file: file, line: line)
        expectation?.fulfill()
    }
    return value == true
}

@discardableResult
func SDAssertFalse(
    _ value: Bool,
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if value {
        XCTFail("\(description): false expected", file: file, line: line)
        expectation?.fulfill()
    }
    return value == false
}

@discardableResult
func SDAssertEqual<T: Equatable>(
    _ lhs: [T],
    _ rhs: [T],
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if lhs != rhs {
        XCTFail("\(description): lhs not equal to rhs", file: file, line: line)
        expectation?.fulfill()
    }
    return lhs == rhs
}

@discardableResult
func SDAssertNotEqual<T: Equatable>(
    _ lhs: [T],
    _ rhs: [T],
    _ description: String,
    _ expectation: XCTestExpectation? = nil,
    file: StaticString = #file,
    line: UInt = #line
) -> Bool {
    if lhs == rhs {
        XCTFail("\(description): lhs equal to rhs", file: file, line: line)
        expectation?.fulfill()
    }
    return lhs != rhs
}

func errorDebugDescription(_ error: Any) -> String {
    let description = String(describing: error).replacingOccurrences(of: "\n", with: ", ")
    return description
}
