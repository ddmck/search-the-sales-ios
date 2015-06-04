//
//  BasketDeliveryItemTableViewCell.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 14/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class BasketDeliveryItemTableViewCell: UITableViewCell {
  var optionsForPicker = [String]()
  @IBOutlet weak var storeLabel: UILabel!
  
  @IBAction func changeButtonPressed(sender: AnyObject) {
//    var optionsForPicker = ["Standard: £1.00", "Express: £3.00"]
    var sizePicker = ActionSheetStringPicker(title: "Choose your Delivery Speed", rows: self.optionsForPicker, initialSelection: 0, doneBlock: {
      picker, index, value in
      println("selected \(value)")
      self.storeLabel.text = "\(value)"
      }, cancelBlock: {
        ActionStringCancelBlock in return
      }, origin: sender.superview!)
    sizePicker.showActionSheetPicker()
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
