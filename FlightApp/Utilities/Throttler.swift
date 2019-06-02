//
//  Throttler.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 02/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import Foundation

public class Throttler {
    private let timeInterval: TimeInterval
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?

    public init(timeInterval: TimeInterval, queue: DispatchQueue) {
        self.timeInterval = timeInterval
        self.queue = queue
    }

    deinit {
        cancel()
    }

    public func throttle(action: @escaping () -> Void) {
        cancel()
        let workItem = DispatchWorkItem { [weak self] in
            action()
            self?.workItem = nil
        }
        self.workItem = workItem
        queue.asyncAfter(deadline: .now() + timeInterval, execute: workItem)
    }

    public func cancel() {
        workItem?.cancel()
        workItem = nil
    }
}
