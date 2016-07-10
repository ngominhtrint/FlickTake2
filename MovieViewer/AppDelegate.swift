//
//  AppDelegate.swift
//  MovieViewer
//
//  Created by Dang Quoc Huy on 6/30/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

let themeColor = UIColor.colorWithRGBHex(0xFFCC00)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setupTabBar()
        setTheme()
        
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

    func setTheme() {
        
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : themeColor]
        UINavigationBar.appearance().tintColor = themeColor
        UINavigationBar.appearance().alpha = 0.8
        
        UITabBar.appearance().tintColor = themeColor
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        UITabBar.appearance().alpha = 0.8
    }
    
    func setupTabBar() {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        // Set up the first View Controller
        let vc1 = storyboard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let nowPlayingController = vc1.viewControllers[0] as! MoviesViewController
        nowPlayingController.viewMode = .NowPlaying
        vc1.tabBarItem.title = "Now Playing"
        vc1.tabBarItem.image = UIImage(named: "nowPlaying")
        
        // Set up the second View Controller
        let vc2 = storyboard.instantiateViewControllerWithIdentifier("MoviesNavigationController") as! UINavigationController
        let topRatedController = vc2.viewControllers[0] as! MoviesViewController
        topRatedController.viewMode = .TopRated
        vc2.tabBarItem.title = "Top Rated"
        vc2.tabBarItem.image = UIImage(named: "topRated")
        
        // Set up the Tab Bar Controller to have two tabs
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [vc1, vc2]
        
        // Make the Tab Bar Controller the root view controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

