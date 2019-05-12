//
//  FavoriteCell.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/9/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    var quote : Quote? {
        didSet {
            quoteLabel.text = quote?.text
            sourceLabel.text = quote?.source?.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
