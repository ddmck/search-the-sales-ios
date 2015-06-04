//
//  AuthenticationViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 25/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire
import Locksmith

class AuthenticationViewController: UIViewController {
  
  @IBOutlet weak var emailInput: UITextField!
  
  @IBOutlet weak var passwordInput: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func SignInButtonPressed(sender: UIButton) {
    Alamofire.request(.POST, "http://localhost:3000/api/auth/sign_in", parameters: ["email": emailInput.text, "password": passwordInput.text])
      .responseJSON { (_, res, JSON, _) in
        println(res)
        println(JSON)
        println(res!.allHeaderFields["access-token"])
        
        if let json = JSON as? Dictionary<String, AnyObject> {
          println("has JSON")
          println(json["data"])
          println(json["id"])
          println("end of JSON")
          var id = json["data"]!["id"] as? NSNumber
          Locksmith.saveData([
            "Access-Token": res!.allHeaderFields["access-token"]! as! String,
            "Client": res!.allHeaderFields["client"]! as! String,
            "Uid": res!.allHeaderFields["uid"]! as! String,
            "Expiry": res!.allHeaderFields["expiry"]! as! String,
            "Name": json["data"]!["name"] as! String,
            "id": "\(id!)"
            ], forUserAccount: "myUserAccount")
        }
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
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
