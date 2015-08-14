//
//  StyleAdviceViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 30/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import UXCam
import Locksmith

class StyleAdviceViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let (userDetails, error) = Locksmith.loadDataForUserAccount("myUserAccount")
    UXCam.tagUsersName(userDetails!["Name"]! as! String, additionalData: nil)
    if justFinishedOnboarding == true {
      justFinishedOnboarding = false
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewControllerWithIdentifier("ChatViewController") as! ChatViewController
      self.navigationController?.pushViewController(vc, animated: false)
    }
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
