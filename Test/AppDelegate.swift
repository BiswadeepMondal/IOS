//
//  AppDelegate.swift
//  Test
//
//  Created by Biswadeep Mondal on 26/07/22.
//

import UIKit
import CleverTapSDK
import UserNotifications
import Adjust
@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,AdjustDelegate{



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CleverTap.autoIntegrate()
        // event without properties
        registerForPush()
        CleverTap.sharedInstance()?.recordEvent("IOS2")
        CleverTap.setDebugLevel(3)
       // var ctid=CleverTap.sharedInstance()?.profileGetAttributionIdentifier(CleverTap)
       
        let yourAppToken = "lysplpl4f75s"
        
        let environment = ADJEnvironmentSandbox
        let adjustConfig = ADJConfig(
            appToken: yourAppToken,
            environment: environment)
        adjustConfig?.logLevel = ADJLogLevelVerbose
        adjustConfig?.delegate = self
        Adjust.appDidLaunch(adjustConfig)
        
       
        // Override point for customization after application launch.
        return true
    }
    
    // MARK : Adjust Delegates
        func adjustAttributionChanged(_ attribution: ADJAttribution?) {
            let campaign = attribution?.campaign
            let source = attribution?.network
            let medium = attribution?.trackerName
            
            CleverTap.sharedInstance()?.pushInstallReferrerSource(source, medium: medium, campaign: campaign)
        }
    
    func registerForPush() {
            // Register for Push notifications
            UNUserNotificationCenter.current().delegate = self
            // request Permissions
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            })
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            
            NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
            
            CleverTap.sharedInstance()?.handleNotification(withData: response.notification.request.content.userInfo)
            
            completionHandler()
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
        //    CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
            completionHandler([.badge, .sound, .alert])
        }
        
        func application(_ application: UIApplication,
                         didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
            completionHandler(UIBackgroundFetchResult.noData)
        }
        
        func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
            NSLog("pushNotificationTapped: customExtras: ", customExtras)
        }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


