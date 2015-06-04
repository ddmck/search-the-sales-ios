//
//  Message.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 25/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import Foundation
import Alamofire

struct Message {
  let message: String
  let senderID: String
  let senderName: String
  let date: NSDate
}

private let dateFormat = "yyyyMMddHHmmss"

private func dateFormatter() -> NSDateFormatter {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = dateFormat
  return dateFormatter
}

func saveMessage(message: String, userID: String) {
  
  Alamofire.request(.POST, "http://localhost:3000/api/messages.json", parameters: ["message": ["text": message, "user_id": userID.toInt()!]])
    .responseJSON { (_,_,JSON,_) in
      println(JSON)
    }

}

private func jsonToMessage(json: Dictionary<String, AnyObject>) -> Message {
  println(json)
  let date = dateFormatter().dateFromString(json["created_at"]! as! String)
  var sndr = json["sender_id"]!
  let sender = "\(sndr)"
  let senderName = json["sender_name"]! as! String
  let text = json["text"]! as! String
  println("\(date) \(sender) \(text)")
  return Message(message: text, senderID: sender, senderName: senderName, date: date!)
}

func fetchMessages(callback: ([Message]) -> ()) {
  Alamofire.request(.GET, "http://localhost:3000/api/messages.json")
    .responseJSON  { (_,_,JSON,_) in
      println(JSON)
      var messages = Array<Message>()
      
      if let array = JSON as? Array<Dictionary<String, AnyObject>> {
        for message in array {
          messages.append(jsonToMessage(message))
        }
      }
      
      callback(messages)
    }
}