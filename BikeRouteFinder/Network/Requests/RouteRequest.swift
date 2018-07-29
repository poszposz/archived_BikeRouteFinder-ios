//
//  RouteRequest.swift
//  BikeRouteFinder
//
//  Created by Jan Posz on 29.07.2018.
//  Copyright © 2018 agh. All rights reserved.
//

import Foundation

internal struct RouteRequest: APIRequest {
    
    typealias ResponseType = Route
    
    private let startLocation: String
    
    private let endLocation: String
    
    init(startLocation: String, endLocation: String) {
        self.startLocation = startLocation
        self.endLocation = endLocation
    }
    
    var path: String {
        return "/route/address"
    }
    
    var query: String? {
        return "startLocation=\(startLocation)&endLocation=\(endLocation)"
    }
}
