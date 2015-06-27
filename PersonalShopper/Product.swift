//
//  Product.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 30/04/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import Foundation

struct Product {
  let id: Int
  let storeID: Int
  let name: String
  let brandName: String
  let price: Double
  let image: String
  var sizes: Array<Dictionary<String, AnyObject>>?
  let url: String
}
