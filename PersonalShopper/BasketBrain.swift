
//
//  BasketBrain.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 12/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import Foundation

private let _BrainSharedInstance = BasketBrain()

class BasketBrain {
  static let sharedInstance = BasketBrain()
  
  var items = Array<BasketItem>()
  
}