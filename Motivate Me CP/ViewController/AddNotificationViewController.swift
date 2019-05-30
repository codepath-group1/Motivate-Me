//
//  AddNotificationViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/24/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

protocol AddNotificationViewControllerDelegate {
    func saveNotification(_ notification: Notification);
    
}

class AddNotificationViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    var notification : Notification?
    var delegate : AddNotificationViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if notification == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let time = dateFormatter.date(from: "08:00")
            notification = ["time": time,
                            "repeat": [true,true,true,true,true,true,true],
                            "quoteList": "Random"]
        }
        let time = notification!["time"] as! Date
        datePicker.date = time
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repeatSegue" {
            if let vc = segue.destination as? DayOfWeekPickerViewController {
                vc.repeatObj = notification!["repeat"] as? Repeat
                vc.delegate = self
            }
        } else if segue.identifier == "quoteListSegue" {
            if let vc = segue.destination as? QuoteListPickerViewController {
                vc.quoteList = notification!["quoteList"] as? QuoteList
                vc.delegate = self
            }
        }
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let delegate = delegate {
            notification!["time"] = datePicker.date
            delegate.saveNotification(notification!)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddNotificationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationPropertyCell", for: indexPath) as?  NotificationPropertyCell else {
            fatalError("Cell casting failed")
        }
        var title = ""
        var value = ""
        if indexPath.row == 0 {
            title = "Repeat"
            value = (notification!["repeat"] as! [Bool]).toString()
        }
        else {
            title = "Quote List"
            value = notification!["quoteList"] as! String
        }
        cell.titleLabel.text = title
        cell.valueLabel.text = value
        return cell
    }
}

extension AddNotificationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "repeatSegue", sender: self)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "quoteListSegue", sender: self)
        }
    }
}

extension AddNotificationViewController : DayOfWeekPickerViewControllerDelegate {
    func dayOfWeekPickerViewControllerWillDismiss(repeatObj: Repeat) {
        notification!["repeat"] = repeatObj
        tableView.reloadData()
    }
}

extension AddNotificationViewController : QuoteListPickerViewControllerDelegate {
    func quoteListPickerViewControllerWillDisappear(quoteList: QuoteList) {
        notification!["quoteList"] = quoteList
        tableView.reloadData()
    }
}
