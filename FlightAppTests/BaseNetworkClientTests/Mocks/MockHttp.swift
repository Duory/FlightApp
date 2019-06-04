//
//  MockHttp.swift
//  FlightAppTests
//
//  Created by Ilyas Siraev on 04/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import XCTest
@testable import FlightApp

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() { }
}

enum MockHttpError: Error {
    case test
}

class MockHttp: Http {
    private let answerDelay: TimeInterval = 1

    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var dataTaskCalled = false

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCalled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + answerDelay) {
            completionHandler(self.data, self.urlResponse, self.error)
        }
        return MockURLSessionDataTask()
    }
}
