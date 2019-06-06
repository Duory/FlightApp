//
//  CubicBezier.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 07/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

// swiftlint:disable identifier_name
struct CubicBezier {
    static func buildPoints(
        start: CGPoint,
        end: CGPoint,
        controlPoint1: CGPoint,
        controlPoint2: CGPoint,
        numberOfPoints: Int
    ) -> [CGPoint] {
        let step = 1.0 / CGFloat(numberOfPoints - 1)
        var percent: CGFloat = 0
        var points: [CGPoint] = []
        (0 ..< numberOfPoints).forEach { _ in
            let x = cubicBezier(percent: percent, start: start.x, end: end.x, control1: controlPoint1.x, control2: controlPoint2.x)
            let y = cubicBezier(percent: percent, start: start.y, end: end.y, control1: controlPoint1.y, control2: controlPoint2.y)
            points.append(CGPoint(x: x, y: y))
            percent += step
        }
        return points
    }

    private static func cubicBezier(percent: CGFloat, start: CGFloat, end: CGFloat, control1: CGFloat, control2: CGFloat) -> CGFloat {
        let offset = 1.0 - percent
        let offsetPow2 = pow(offset, 2)
        let offsetPow3 = pow(offset, 3)
        let percentPow2 = pow(percent, 2)
        let percentPow3 = pow(percent, 3)
        return start * offsetPow3 + 3 * control1 * offsetPow2 * percent + 3 * control2 * offset * percentPow2 + end * percentPow3
    }
}
// swiftlint:enable identifier_name
