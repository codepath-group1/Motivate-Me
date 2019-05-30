//
//  DayOfWeekPickerViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/24/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

protocol DayOfWeekPickerViewControllerDelegate {
    func dayOfWeekPickerViewControllerWillDismiss(repeatObj : Repeat);
}

class DayOfWeekPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var repeatObj : Repeat!
    var delegate : DayOfWeekPickerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent {
            if let delegate = delegate {
                delegate.dayOfWeekPickerViewControllerWillDismiss(repeatObj: repeatObj)
            }
        }
    }
}

extension DayOfWeekPickerViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let addNotificationVC = viewController as? AddNotificationViewController {
            addNotificationVC.notification?["repeat"] = repeatObj
        }
    }
}

extension DayOfWeekPickerViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayOfWeekCell", for: indexPath)
        cell.textLabel?.text = "Every " + daysOfWeek[indexPath.row]
        if repeatObj[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

extension DayOfWeekPickerViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)!
        repeatObj[indexPath.row] = !(repeatObj[indexPath.row])
        if repeatObj[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
