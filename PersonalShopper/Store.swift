//
//  Store.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 18/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import Foundation

struct Store {
  let id: Int
  let name: String
  let stdDeliveryPrice: Double
  let expDeliveryPrice: Double
  let freeDeliveryThreshold: Double
  
  func displayStdDeliveryPrice(spend: Double) -> Double {
    if spend >= freeDeliveryThreshold {
      return 0.0
    } else {
      return stdDeliveryPrice
    }
  }
}
