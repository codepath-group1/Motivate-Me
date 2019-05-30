//
//  HomeCardButton.swift
//  Motivate Me CP
//
//  Created by Joy_Wang on 5/23/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

class HomeCardButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if(imageView != nil){
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: (bounds.width - 30))
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
