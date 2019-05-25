//
//  NotificationCell.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/24/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var repeatLabel: UILabel!
    var notification : Notification! {
        didSet {
            if let repeatObj = notification["repeat"] as? Repeat,
                let time = notification["time"] as? Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                timeLabel.text = dateFormatter.string(from: time)
                repeatLabel.text = repeatObj.toString()
            }
        }
    }
}
