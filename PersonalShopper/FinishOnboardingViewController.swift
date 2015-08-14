//
//  FinishOnboardingViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 30/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire

var justFinishedOnboarding = false

class FinishOnboardingViewController: UIViewController {
  
  @IBAction func finishButtonPressed(sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let tabVC = storyboard.instantiateViewControllerWithIdentifier("TabViewController") as! UITabBarController
    Alamofire.request(.PUT, "\(GlobalConstants.backendURL)api/auth.json", parameters: ["quiz_results": ["brands": selectedBrands, "looks": selectedLooks]])
      .responseJSON {(_,res,JSON,_) in
        println(res)
    }
    justFinishedOnboarding = true
    self.presentViewController(tabVC, animated: true, completion: nil)
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
