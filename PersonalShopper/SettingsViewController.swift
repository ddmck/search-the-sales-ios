//
//  SettingsViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 19/06/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Locksmith
import Alamofire

class SettingsViewController: UIViewController {
  
  @IBAction func signOutButtonPressed(sender: UIButton) {
    Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
      "Access-Token": "",
      "Client": "",
      "Uid": "",
      "Expiry": ""
    ]
    
    Locksmith.deleteDataForUserAccount("myUserAccount")
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("LogInViewController") as! UIViewController
    
    self.presentViewController(vc, animated: true, completion: nil)

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
