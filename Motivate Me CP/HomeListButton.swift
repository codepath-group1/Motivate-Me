//
//  HomeListButton.swift
//  Motivate Me CP
//
//  Created by Joy_Wang on 5/12/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

class HomeListButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
            if imageView != nil{
                imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 5), bottom: 5, right: 5)
            }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
