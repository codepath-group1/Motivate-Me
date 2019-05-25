//
//  ProfileViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/2/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

typealias Repeat = [Bool]
typealias QuoteList = String
typealias Notification = [String: Any]

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var notifications: [Notification] = []
    var notificationIndex : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotifications()
        tableView.reloadData()
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
           let indexPath = sender as? IndexPath,
           let vc = nc.topViewController as? AddNotificationViewController {
            vc.notification = notifications[indexPath.row]
            vc.delegate = self
            if segue.identifier == "NotificationCellSegue" {
                notificationIndex = indexPath.row
            } else {
                notificationIndex = nil
            }
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
    
}

extension ProfileViewController : AddNotificationViewControllerDelegate {
    func saveNotification(_ notification: Notification) {
        if let index = notificationIndex {
            notifications[index] = notification
        } else {
            notifications.append(notification)
        }
        UserDefaults.standard.set(notifications, forKey: "notifications")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        loadNotifications()
        tableView.reloadData()
    }
}
