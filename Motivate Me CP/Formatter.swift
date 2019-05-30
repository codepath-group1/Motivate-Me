//
//  Formatter.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/24/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import Foundation

extension Array where Element == Bool {
    func toString() -> String {
        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        var tCount = 0
        var res = ""
        for i in 0..<self.count {
            let flag = self[i]
            if flag {
                tCount += 1
                res += days[i] + " "
            }
        }
        if tCount == days.count { return "Everyday" }
        else if tCount > 0 { return res }
        else { return "" }
    }
}
