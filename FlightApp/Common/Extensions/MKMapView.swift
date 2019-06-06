//
//  MKMapView.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 06/06/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import MapKit

extension MKMapView {
    func dequeueReusableAnnotationView<T: MKAnnotationView>() -> T? {
        return dequeueReusableAnnotationView(withIdentifier: T.reusableIdentifier) as? T
    }

    func fitAll(edgePadding: UIEdgeInsets, animated: Bool) {
        var zoomRect = MKMapRect.null
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01)
            zoomRect = zoomRect.union(pointRect)
        }
        setVisibleMapRect(zoomRect, edgePadding: edgePadding, animated: animated)
    }
}

extension MKMapPoint {
    var cgPoint: CGPoint {
        return CGPoint(x: x, y: y)
    }
}
