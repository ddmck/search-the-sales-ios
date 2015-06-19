//
//  APIBrain.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 04/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import Foundation

private let _BrainSharedInstance = APIBrain()

class APIBrain {
  static let sharedInstance = APIBrain()
  var page: Int
  var searchString = String()
  var filters = [String: AnyObject]()
  var changed: Bool
  
  init(){
    self.changed = true
    self.page = 1
    self.filters["out_of_stock"] = false
//    self.searchString = "Boo"
  }
}
