//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Mai Nguyen Quang Tri on 4/13/17.
//  Copyright © 2017 Mai Nguyen Quang Tri. All rights reserved.
//

import UIKit
import Repro
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isTesting: Bool = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if self.isTesting{
            Repro.setup("11d1a862-78f7-4c99-bd83-e27772afb86a")
        }else{
            Repro.setup("48f5dc6f-af86-47e8-ae50-2b62c7da9397")
        }
        Repro.startRecording()
        Fabric.with([Crashlytics.self])
        
        let notiType:UIUserNotificationType = [.alert, .badge, .sound]
        let settings = UIUserNotificationSettings(types: notiType, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
        UIApplication.shared.registerForRemoteNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        DispatchQueue.main.async(execute: {
            Repro.setPushDeviceToken(deviceToken)
            Repro.setUserID(Repro.getDeviceID())
            print("Repro.getDeviceID() = \(Repro.getDeviceID())")
        })
    
        //let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("------>>>userInfo = \(userInfo)")
        
        
    }
}

