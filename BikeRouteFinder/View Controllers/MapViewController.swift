//
//  MapViewController.swift
//  BikeRouteFinder
//
//  Created by Jan Posz on 30.06.2018.
//  Copyright © 2018 agh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    /// "207.154.252.142"
    /// "172.19.44.82"
    private lazy var networkClient = DefaultNetworkClient(requestBuilder: DefaultRequestBuilder(scheme: .http, host: "172.19.44.82", port: 3000))
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        let constraints = [mapView.topAnchor.constraint(equalTo: view.topAnchor),
                           mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
                           mapView.leftAnchor.constraint(equalTo: view.leftAnchor)]
        NSLayoutConstraint.activate(constraints)
        downloadMapData(start: "wielicka", end: "ludowa")
    }
    
    private func downloadMapData(start: String, end: String) {
        let request = GraphVisualiztionRequest(startLocation: start, endLocation: end)
//        let request = RouteRequest(startLocation: start, endLocation: end)
        networkClient.perform(request: request) { [weak self] result in
            switch result {
            case .success(let routes):
                self?.draw(routes: routes)
            case .error(let error):
                print("Error: " + error.localizedDescription)
            }
        }
    }
    
    private func draw(routes: [Route]) {
        routes.forEach {
            self.draw(route: $0)
        }
    }
    
    private func draw(route: Route) {
        let region = MKCoordinateRegion(center: route.startPoint, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        mapView.setRegion(region, animated: true)
        draw(segments: route.segments)
        let startAnnotation = MKPointAnnotation()
        startAnnotation.coordinate = route.startPoint
        mapView.addAnnotation(startAnnotation)
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = route.endPoint
        mapView.addAnnotation(endAnnotation)
    }
    
    private func draw(segments: [Segment]) {
        let coordinateGroups = segments.map { [$0.start, $0.end] }
        coordinateGroups.forEach {
            let route = MKPolyline(coordinates: $0, count: 2)
            mapView.add(route)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.fillColor = .blue
        renderer.strokeColor = .blue
        renderer.lineWidth = 3
        return renderer
    }
}
