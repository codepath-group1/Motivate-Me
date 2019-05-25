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
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotifications()
    }
    
    func loadNotifications() {
        let ary = UserDefaults.standard.array(forKey: "notifications") ?? []
        for i in 0 ..< ary.count {
            if let notification = ary[i] as? Notification {
                notifications.append(notification)
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
