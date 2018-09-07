//
//  Segment.swift
//  BikeRouteFinder
//
//  Created by Jan Posz on 29.07.2018.
//  Copyright © 2018 agh. All rights reserved.
//

import Foundation
import CoreLocation

internal struct Segment {
    
    /// Start location of the segment.
    let start: CLLocationCoordinate2D
    
    /// End location of the segment.
    let end: CLLocationCoordinate2D
    
    /// Segment length in meters.
    let length: Int
    
    /// The name of a segment.
    let name: String
    
    /// True if the segment starts the route.
    let isBeginning: Bool
    
    /// True if the segment ends the route.
    let isEnding: Bool
}

extension Segment: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case start
        case end
        case isBeginning
        case isEnding
        case length
        case routeName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        start = try container.decode(CLLocationCoordinate2D.self, forKey: .start)
        end = try container.decode(CLLocationCoordinate2D.self, forKey: .end)
        isBeginning = try container.decodeIfPresent(Bool.self, forKey: .isBeginning) ?? false
        isEnding = try container.decodeIfPresent(Bool.self, forKey: .isEnding) ?? false
        length = try container.decode(Int.self, forKey: .length)
        name = try container.decode(String.self, forKey: .routeName)
    }
}
