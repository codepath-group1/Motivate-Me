//
//  FavoriteCell.swift
//  Motivate Me CP
//
//  Created by Joy_Wang on 5/7/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var FavoriteQuoteLabel: UILabel!
    @IBOutlet weak var FavoriteAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
