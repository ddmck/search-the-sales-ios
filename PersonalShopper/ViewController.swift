//
//  ViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 28/04/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    println("view did load")
    Alamofire.request(.POST, "http://localhost:3000/api/auth/sign_in", parameters: ["email": "donald@searchthesales.com", "password": "Tetrahedral1"])
      .responseJSON { (_, res, JSON, _) in
        println(res)
        println(res!.allHeaderFields["access-token"])
        Locksmith.saveData([
          "Access-Token": res!.allHeaderFields["access-token"]! as! String,
          "Client": res!.allHeaderFields["client"]! as! String,
          "Uid": res!.allHeaderFields["uid"]! as! String,
          "Expiry": res!.allHeaderFields["expiry"]! as! String
          ], forUserAccount: "myUserAccount")
        
        let (userDetails, error) = Locksmith.loadDataForUserAccount("myUserAccount")
        println(userDetails)
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
          "Access-Token": userDetails!["Access-Token"]! as! String,
          "Client": userDetails!["Client"]! as! String,
          "Uid": userDetails!["Uid"]! as! String,
          "Expiry": userDetails!["Expiry"]! as! String
        ]
        
        Alamofire.request(.GET, "http://localhost:3000/api/wishlist_items.json")
          .responseJSON { (_,_,JSON,_) in
            println(JSON)
            
        }
    }
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

