//
//  BasketItemTableViewCell.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 12/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

class BasketItemTableViewCell: UITableViewCell {

  @IBOutlet weak var basketImage: UIImageView!

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
