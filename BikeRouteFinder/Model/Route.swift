//
//  Route.swift
//  BikeRouteFinder
//
//  Created by Jan Posz on 29.07.2018.
//  Copyright © 2018 agh. All rights reserved.
//

import Foundation

internal struct Route {
    
    /// All segments a route is composed from.
    let segments: [Segment]
}

extension Route: Decodable {
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        segments = try container.decode([Segment].self)
    }
}
