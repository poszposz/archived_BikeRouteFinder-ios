//
//  Result.swift
//  BikeRouteFinder
//
//  Created by Jan Posz on 29.07.2018.
//  Copyright © 2018 agh. All rights reserved.
//

import Foundation

internal enum Result<T> {
    case success(T)
    case error(Error)
}
