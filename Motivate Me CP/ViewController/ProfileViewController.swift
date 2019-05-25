//
//  ProfileViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/2/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData


typealias Repeat = [Bool]
typealias QuoteList = String
typealias Notification = [String: Any]

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var notifications: [Notification] = []
    var notificationIndex : Int?
    var isAllowed = false
    var quotes : [Quote]!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotifications()
        tableView.reloadData()
        loadQuotes()
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                self.isAllowed = true
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "NewNotificationSegue", sender: nil)
    }
    func loadNotifications() {
        let ary = UserDefaults.standard.array(forKey: "notifications") ?? []
        notifications = []
        for i in 0 ..< ary.count {
            if let notification = ary[i] as? Notification {
                notifications.append(notification)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nc = segue.destination as? UINavigationController,
           let vc = nc.topViewController as? AddNotificationViewController {
            vc.delegate = self
            if segue.identifier == "NotificationCellSegue" {
                let indexPath = sender as! IndexPath
                vc.notification = notifications[indexPath.row]
                notificationIndex = indexPath.row
            } else {
                notificationIndex = nil
            }
        }
    }
    
    func scheduleNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let notificationNum = 10
        var dates : [Date] = []
        var counter = 0
        let dayOfWeekIndex = Calendar.current.dateComponents([.weekday], from: Date()).weekday!
        notificationCenter.removeAllPendingNotificationRequests()
        if self.notifications.count > 0 {
            for i in 0..<100 {
                counter = i / self.notifications.count
                let index = i % self.notifications.count
                let notification = self.notifications[index]
                let time = notification["time"] as! Date
                let repeatObj = notification["repeat"] as! Repeat
                var offsetDay = 0
                while !(repeatObj[(dayOfWeekIndex+offsetDay)%7]) || counter > 0 {
                    if repeatObj[(dayOfWeekIndex+offsetDay)%7] { counter -= 1}
                    offsetDay += 1
                }
                let offsetedDate = Calendar.current.date(byAdding: .day, value: offsetDay, to: Date())!
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: time)
                let minute = calendar.component(.minute, from: time)
                let date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: offsetedDate)!
                dates.append(date)
            }
            dates.sort()
            for i in 0..<notificationNum {
                let date = dates[i]
                if Date() > date { continue }
                let content = UNMutableNotificationContent()
                let quote = self.quotes[Int.random(in: 0 ..< self.quotes.count)]
                content.title = (quote.source?.title!) ?? "No Name"
                content.body = quote.text!
                content.sound = UNNotificationSound.default
                content.userInfo = ["quoteId":quote.id]
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: date)
                print(triggerDate)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                let identifier = String(i)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                notificationCenter.add(request) { (error) in
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func loadQuotes() {
        let fetchRequest: NSFetchRequest<QuoteData> = QuoteData.fetchRequest()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let moc = delegate.persistentContainer.viewContext
        
        do {
            let quoteDatas = try moc.fetch(fetchRequest)
            // TODO: extract only favorited quotes
            if let results = quoteDatas[0].results as? Set<Quote> {
                quotes = Array(results)
            }
        } catch {
            fatalError("There was an error fetching the list of favorited quotes!")
        }
    }
}

extension ProfileViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else {
            fatalError("Cell Casting failed")
        }
        cell.notification = notifications[indexPath.row]
        return cell
    }
}

extension ProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "NotificationCellSegue", sender: indexPath)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notifications.remove(at: indexPath.row)
            UserDefaults.standard.set(notifications, forKey: "notifications")
            UserDefaults.standard.synchronize()
            tableView.deleteRows(at: [indexPath], with: .fade)
            scheduleNotification()
        }
    }
}

extension ProfileViewController : AddNotificationViewControllerDelegate {
    func saveNotification(_ notification: Notification) {
        if let index = notificationIndex {
            notifications[index] = notification
        } else {
            notifications.append(notification)
        }
        UserDefaults.standard.set(notifications, forKey: "notifications")
        UserDefaults.standard.synchronize()
        tableView.reloadData()
        scheduleNotification()
    }
}
