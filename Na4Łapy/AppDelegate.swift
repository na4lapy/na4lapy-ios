//
//  AppDelegate.swift
//  Na4Łapy
//
//  Created by Andrzej Butkiewicz on 05.06.2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red:0.00, green:0.41, blue:0.45, alpha:1.00)
        UINavigationBar.appearance().barStyle = UIBarStyle.Black

        setAnimalPreferencesStartingState()

        return true
    }

    func setAnimalPreferencesStartingState() {

        let appWasLaunchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore")

        if !appWasLaunchedBefore {
            //set preferences state for the start
            UserPreferences(
                typeDog: false,
                typeCat: false,
                typeOther: false,
                genderFemale: true,
                genderMale: true,
                ageMin: 1,
                ageMax: 15,
                sizeSmall: true,
                sizeMedium: true,
                sizeLarge: false,
                activityLow: false,
                activityHigh: true
                ).savePreferencesToUserDefault()

            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
        }

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
