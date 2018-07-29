//
//  AppDelegate.swift
//  BikeRouteFinder
//
//  Created by Jan Posz on 30.06.2018.
//  Copyright © 2018 agh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        return window
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let mapViewController = MapViewController()
        window?.rootViewController = mapViewController
        window?.makeKeyAndVisible()
        return true
    }
}

