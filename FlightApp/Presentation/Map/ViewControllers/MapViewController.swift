//
//  MapViewController.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

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

    private var planePositionUpdateTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        addAnnotationsAndOverlaysToMapView()
        updatePlanePosition()
        setupPlanePositionUpdateTimer()
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

    private func setupPlanePositionUpdateTimer() {
        if planePositionUpdateTimer != nil {
            invalidatePlanePositionUpdateTimer()
        }

        let timer = Timer(timeInterval: 0.5, target: self, selector: #selector(updatePlanePosition), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        planePositionUpdateTimer = timer
    }

    private func invalidatePlanePositionUpdateTimer() {
        planePositionUpdateTimer?.invalidate()
        planePositionUpdateTimer = nil
    }

    @objc private func callDismissAction() {
        invalidatePlanePositionUpdateTimer()
        actions.dismiss()
    }

    // MARK: - MapView Handling

    private let mapEdgePadding = UIEdgeInsets(top: 75, left: 75, bottom: 75, right: 75)
    private let flightpathPointsCount = 100
    private var planeAnnotationPosition = 0
    private let planeMovingStep = 1
    private var flightpathPolyline: MKPolyline?
    private var planeAnnotation: PlaneAnnotation?
    private var planeAnnotationView: MKAnnotationView?

    private func addAnnotationsAndOverlaysToMapView() {
        let fromAirportAnnotation = AirportAnnotation(airport: data.fromAirport)
        let toAirportAnnotation = AirportAnnotation(airport: data.toAirport)
        mapView.addAnnotations([ fromAirportAnnotation, toAirportAnnotation ])

        let flightpathPoints = calculateFlightpathPoints(
            from: MKMapPoint(fromAirportAnnotation.coordinate),
            to: MKMapPoint(toAirportAnnotation.coordinate)
        )
        let flightpathPolyline = MKPolyline(points: flightpathPoints, count: flightpathPoints.count)
        self.flightpathPolyline = flightpathPolyline
        mapView.addOverlay(flightpathPolyline)

        let planeAnnotation = PlaneAnnotation(
            planeImage: UIImage(named: "plane_icon") ?? UIImage(),
            coordinate: fromAirportAnnotation.coordinate
        )
        self.planeAnnotation = planeAnnotation
        mapView.addAnnotation(planeAnnotation)
        mapView.fitAll(edgePadding: mapEdgePadding, animated: false)
    }

    private func calculateFlightpathPoints(from start: MKMapPoint, to end: MKMapPoint) -> [MKMapPoint] {
        let middle = pointBetweenPoints(start, end)
        let degrees: Double = 60
        let controlPoint1 = thirdPointOfTriangle(
            pointA: middle.cgPoint,
            pointB: start.cgPoint,
            angleA: CGFloat(degrees.radians),
            angleB: CGFloat(degrees.radians)
        )
        let controlPoint2 = thirdPointOfTriangle(
            pointA: middle.cgPoint,
            pointB: end.cgPoint,
            angleA: CGFloat(degrees.radians),
            angleB: CGFloat(degrees.radians)
        )
        return CubicBezier.buildPoints(
            start: start.cgPoint,
            end: end.cgPoint,
            controlPoint1: controlPoint1,
            controlPoint2: controlPoint2,
            numberOfPoints: flightpathPointsCount
        ).map { MKMapPoint(x: Double($0.x), y: Double($0.y)) }
    }

    @objc private func updatePlanePosition() {
        guard
            let flightpathPolyline = flightpathPolyline,
            let planeAnnotation = planeAnnotation,
            planeAnnotationPosition + planeMovingStep < flightpathPolyline.pointCount
        else { return invalidatePlanePositionUpdateTimer() }

        let points = flightpathPolyline.points()
        let previousMapPoint = points[planeAnnotationPosition]
        planeAnnotationPosition += planeMovingStep
        let nextMapPoint = points[planeAnnotationPosition]

        let planeDirection = directionBetweenPoints(previousMapPoint, nextMapPoint)
        let animation = {
            planeAnnotation.coordinate = nextMapPoint.coordinate
            self.planeAnnotationView?.transform = CGAffineTransform(rotationAngle: CGFloat((planeDirection - 90).radians))
        }
        UIView.animate(
            withDuration: planeAnnotationPosition == planeMovingStep ? 0 : 1,
            delay: 0,
            options: [ .beginFromCurrentState, .allowUserInteraction ],
            animations: animation,
            completion: nil
        )
    }

    // MARK: - MKMapViewDelegate

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer(overlay: overlay) }

        let renderer = MKPolylineRenderer(overlay: polyline)
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

    // swiftlint:disable identifier_name
    private func pointBetweenPoints(_ point1: MKMapPoint, _ point2: MKMapPoint) -> MKMapPoint {
        let x = point1.x + 0.5 * (point2.x - point1.x)
        let y = point1.y + 0.5 * (point2.y - point1.y)
        return MKMapPoint(x: x, y: y)
    }

    private func directionBetweenPoints(_ sourcePoint: MKMapPoint, _ destinationPoint: MKMapPoint) -> CLLocationDirection {
        let xLength = destinationPoint.x - sourcePoint.x
        let yLength = destinationPoint.y - sourcePoint.y
        return atan2(yLength, xLength).degrees.truncatingRemainder(dividingBy: 360) + 90
    }

    private func thirdPointOfTriangle(pointA: CGPoint, pointB: CGPoint, angleA: CGFloat, angleB: CGFloat) -> CGPoint {
        let x1 = pointA.x
        let y1 = pointA.y
        let x2 = pointB.x
        let y2 = pointB.y
        let u = x2 - x1
        let v = y2 - y1
        let a3 = sqrt(u * u + v * v)
        let alp3 = .pi - angleA - angleB
        let a2 = a3 * sin(angleB) / sin(alp3)
        let RHS1 = x1 * u + y1 * v + a2 * a3 * cos(angleA)
        let RHS2 = y2 * u - x2 * v + a2 * a3 * sin(angleA)
        let x3 = (1 / (a3 * a3)) * (u * RHS1 - v * RHS2)
        let y3 = (1 / (a3 * a3)) * (v * RHS1 + u * RHS2)
        return CGPoint(x: x3, y: y3)
    }
    // swiftlint:enable identifier_name
}
