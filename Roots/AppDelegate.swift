//
//  AppDelegate.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/3/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import DigitsKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        application.applicationSupportsShakeToEdit = true
        
        Parse.setApplicationId("NnH1QsekkEG0ZM3sEexTk3Hm0gUcyfOqenf4SHva", clientKey: "Y9Crxp76ZBd8cM2rmFCKeUwwOe51t1K7mr37vN1e")
        Fabric.with([Crashlytics.self, Digits.self])
        
        if PFUser.currentUser() == nil {
            window?.rootViewController = LoginViewController.instantiateFromStoryboard()
            window?.makeKeyAndVisible()
        }

        return true
    }

}

