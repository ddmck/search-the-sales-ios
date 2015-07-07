//
//  RecommendationCollectionViewCell.swift
//  HowAbout
//
//  Created by Donald McKendrick on 03/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var image1: UIImageView!
  @IBOutlet weak var image2: UIImageView!
  @IBOutlet weak var image3: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var fromLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
