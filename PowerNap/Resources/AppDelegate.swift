//
//  AppDelegate.swift
//  PowerNap
//
//  Created by Kaden Hendrickson on 5/7/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("Notifications were granted? \(granted)")
        }
        return true
    }

}

