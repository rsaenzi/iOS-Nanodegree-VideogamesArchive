//
//  AppDelegate.swift
//  VideogamesArchive
//
//  Created by Rigoberto Sáenz Imbacuán on 1/1/18.
//  Copyright © 2018 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Global tint colors
        window?.tintColor = #colorLiteral(red: 0.9992868304, green: 0.1656406224, blue: 0.1659538746, alpha: 1)
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9992868304, green: 0.1656406224, blue: 0.1659538746, alpha: 1)
        
        // Config for Kingfisher
        ImageCache.default.maxDiskCacheSize = 0
        ImageCache.default.maxCachePeriodInSecond = -1
        ImageDownloader.default.downloadTimeout = 30.0
        
        return true
    }
}
