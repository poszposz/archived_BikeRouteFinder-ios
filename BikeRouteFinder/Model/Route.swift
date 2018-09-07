//
//  Route.swift
//  BikeRouteFinder
//
//  Created by Jan Posz on 29.07.2018.
//  Copyright © 2018 agh. All rights reserved.
//

import Foundation
import CoreLocation

internal struct Route {
    
    /// The category of the route.
    let category: String

    /// The name of the route, typically the street name.
    let name: String
    
    /// A start coordinate of the route.
    let startPoint: CLLocationCoordinate2D
    
    /// An end coordinate of the route.
    let endPoint: CLLocationCoordinate2D
    
    /// Total length of the route.
    let length: Int
    
    /// All segments a route is composed from.
    let segments: [Segment]
}

extension Route: Decodable {
    
    private enum CodingKeys: CodingKey {
        case segments
        case totalLength
        case category
        case name
        case start
        case end
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        segments = try container.decode([Segment].self, forKey: .segments)
        startPoint = try container.decode(CLLocationCoordinate2D.self, forKey: .start)
        endPoint = try container.decode(CLLocationCoordinate2D.self, forKey: .end)
        category = try container.decode(String.self, forKey: .category)
        name = try container.decode(String.self, forKey: .name)
        length = try container.decode(Int.self, forKey: .totalLength)
    }
}
