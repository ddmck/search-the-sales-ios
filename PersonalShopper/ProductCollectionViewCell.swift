//
//  ProductCollectionViewCell.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 08/06/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {


//  required init(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//  }
//  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    contentView.addSubview(imageView)
    self.backgroundColor = UIColor.blueColor()
    let textFrame = CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/3)
    let textLabel: UILabel = UILabel(frame: textFrame)
    textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
    textLabel.textAlignment = .Center
    contentView.addSubview(textLabel)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  
}