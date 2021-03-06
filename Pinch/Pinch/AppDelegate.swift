//
//  AppDelegate.swift
//  Pinch
//
//  Created by Cameron Wu on 10/15/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Output the names of fonts included, for debugging
        /*for family: String in UIFont.familyNames() {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }*/
        
        Parse.setApplicationId("4RZ12Y8iVbZ6ZsH2EGCp5PeJPMJ9Sc9e1mTFhW2T",
            clientKey: "8qrF3DKGjQbmRv3nFgSw7YU1K9AKaQ8zsO567qvb")
        
        // Custom navigation bar style
        UINavigationBar.appearance().barTintColor = colorBrandGreen
        UINavigationBar.appearance().tintColor = UIColorFromRGB("FFFFFF")
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Raleway-Bold", size: 17)!, NSForegroundColorAttributeName:UIColor.whiteColor()]
            
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "icon_back_arrow_white_23x14")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal).imageWithAlignmentRectInsets(UIEdgeInsetsMake(0, 0, -3, 0))
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "icon_back_arrow_white_23x14")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal).imageWithAlignmentRectInsets(UIEdgeInsetsMake(0, 0, -3, 0))
        
        generateTestEvents()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

