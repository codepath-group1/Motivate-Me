//
//  AppDelegate.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 4/30/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if !(UserDefaults.standard.bool(forKey: "FirstLaunchDone")) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let time = dateFormatter.date(from: "08:00")
            let notification : Notification = ["time": time as Any,
                                               "repeat": [true,true,true,true,true,true,true],
                                               "quoteList": "Random"]
            UserDefaults.standard.set([notification], forKey: "notifications")
            UserDefaults.standard.synchronize()

            guard let success = try?loadData() else {
                return true
            }
            if success {
                UserDefaults.standard.set(true, forKey: "FirstLaunchDone")
                UserDefaults.standard.synchronize()
            }
        }
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        UserDefaults.standard.set(-1, forKey: "quoteId")
        UserDefaults.standard.synchronize()
  
        return true
    }

    func loadData() throws -> Bool  {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let moc = delegate.persistentContainer.viewContext
        let decoder = JSONDecoder()
        guard let contextKey = CodingUserInfoKey.managedObjectContext else {return false}
        decoder.userInfo[contextKey] = moc
        guard let path = Bundle.main.path(forResource: "englishQuotes", ofType: "json") else {return false}
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoded = try decoder.decode(QuoteData.self, from: data)
        saveContext()
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Motivate_Me_CP")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let quoteId = response.notification.request.content.userInfo["quoteId"] as? Int,
            let tab = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            UserDefaults.standard.set(quoteId, forKey: "quoteId")
            UserDefaults.standard.synchronize()
            tab.selectedIndex = 0
        }
    }
}
