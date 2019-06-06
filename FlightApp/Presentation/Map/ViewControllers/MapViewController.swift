//
//  MapViewController.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet private var mapView: MKMapView!

    struct Data {
        let fromAirport: Airport
        let toAirport: Airport
    }

    struct Actions {
        let dismiss: () -> Void
    }

    var data: Data!
    var actions: Actions!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        addAnnotationToMapView()
    }

    private func setup() {
        title = Localization.Map.flightRoute
        view.backgroundColor = Style.Color.blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(callDismissAction)
        )
        mapView.register(AirportAnnotationView.self, forAnnotationViewWithReuseIdentifier: AirportAnnotationView.reusableIdentifier)
        mapView.register(PlaneAnnotationView.self, forAnnotationViewWithReuseIdentifier: PlaneAnnotationView.reusableIdentifier)
    }

    @objc private func callDismissAction() {
        invalidateUpdateTimer()
        actions.dismiss()
    }

    // MARK: - MapView Handling

    private var updateTimer: Timer?
    private var flightpathPolyline: MKPolyline?
    private var planeAnnotation: PlaneAnnotation?
    private var planeAnnotationPosition = 0
    private let planeMovingStep = 25
    private var planeAnnotationView: MKAnnotationView?

    private func addAnnotationToMapView() {
        let fromAirportAnnotation = AirportAnnotation(airport: data.fromAirport)
        let toAirportAnnotation = AirportAnnotation(airport: data.toAirport)
        mapView.addAnnotations([ fromAirportAnnotation, toAirportAnnotation ])

        let coordinates = [ fromAirportAnnotation.coordinate, toAirportAnnotation.coordinate ]
        let flightpathPolyline = MKGeodesicPolyline(coordinates: coordinates, count: 2)
        self.flightpathPolyline = flightpathPolyline
        mapView.addOverlay(flightpathPolyline)

        let planeAnnotation = PlaneAnnotation(
            planeImage: UIImage(named: "plane_icon") ?? UIImage(),
            coordinate: fromAirportAnnotation.coordinate
        )
        mapView.addAnnotation(planeAnnotation)

        self.planeAnnotation = planeAnnotation
        let edgePadding = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 75)
        mapView.fitAll(edgePadding: edgePadding, animated: false)
        updatePlanePosition()
        setupUpdateTimer()
    }

    @objc private func updatePlanePosition() {
        guard
            let flightpathPolyline = flightpathPolyline,
            let planeAnnotation = planeAnnotation,
            planeAnnotationPosition + planeMovingStep < flightpathPolyline.pointCount
        else { return invalidateUpdateTimer() }

        let points = flightpathPolyline.points()
        let previousMapPoint = points[planeAnnotationPosition]
        planeAnnotationPosition += planeMovingStep
        let nextMapPoint = points[planeAnnotationPosition]

        let planeDirection = directionBetweenPoints(previousMapPoint, nextMapPoint)
        let animation = {
            planeAnnotation.coordinate = nextMapPoint.coordinate
            self.planeAnnotationView?.transform = CGAffineTransform(
                rotationAngle: CGFloat(self.degreesToRadians(degrees: planeDirection - 90))
            )
        }
        UIView.animate(
            withDuration: planeAnnotationPosition == planeMovingStep ? 0 : 1,
            delay: 0,
            options: [ .beginFromCurrentState, .allowUserInteraction ],
            animations: animation,
            completion: nil
        )
    }

    private func setupUpdateTimer() {
        guard updateTimer == nil else { return }

        let timer = Timer(timeInterval: 0.5, target: self, selector: #selector(updatePlanePosition), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        updateTimer = timer
    }

    private func invalidateUpdateTimer() {
        updateTimer?.invalidate()
        updateTimer = nil
    }

    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = Style.Color.blue
        renderer.lineWidth = 3
        renderer.lineDashPattern = [3, 6]
        return renderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }

        switch annotation {
            case let annotation as AirportAnnotation:
                let view: AirportAnnotationView? = mapView.dequeueReusableAnnotationView()
                view?.update(with: annotation.airport)
                return view
            case let annotation as PlaneAnnotation:
                let view: PlaneAnnotationView? = mapView.dequeueReusableAnnotationView()
                view?.image = annotation.planeImage
                view?.isSelected = true
                planeAnnotationView = view
                return view
            default:
                return nil
        }
    }

    // MARK: - Helpers

    private func directionBetweenPoints(_ sourcePoint: MKMapPoint, _ destinationPoint: MKMapPoint) -> CLLocationDirection {
        let xLength = destinationPoint.x - sourcePoint.x
        let yLength = destinationPoint.y - sourcePoint.y
        return radiansToDegrees(radians: atan2(yLength, xLength)).truncatingRemainder(dividingBy: 360) + 90
    }

    private func radiansToDegrees(radians: Double) -> Double {
        return radians * 180 / .pi
    }

    private func degreesToRadians(degrees: Double) -> Double {
        return degrees * .pi / 180
    }
}
