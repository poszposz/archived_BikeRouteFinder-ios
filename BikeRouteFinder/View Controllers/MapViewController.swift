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

    private lazy var networkClient = DefaultNetworkClient(requestBuilder: DefaultRequestBuilder(scheme: .http, host: "http://207.154.252.142", port: 3000))
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
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
        let request = RouteRequest(startLocation: start, endLocation: end)
        networkClient.perform(request: request) { [weak self] result in
            switch result {
            case .success(let route):
                self?.draw(route: route)
            case .error(let error):
                print("Error: " + error.localizedDescription)
            }
        }
    }
    
    private func draw(route: Route) {
        
    }
}
