//
//  RecommendationItemCollectionViewCell.swift
//  HowAbout
//
//  Created by Donald McKendrick on 05/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

class RecommendationItemCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var brandLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var descriptionView: UITextView!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
}
