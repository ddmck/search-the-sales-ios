//
//  StartOnboardingViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 12/08/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

class StartOnboardingViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var type = UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound;
    var setting = UIUserNotificationSettings(forTypes: type, categories: nil);
    UIApplication.sharedApplication().registerUserNotificationSettings(setting);
    UIApplication.sharedApplication().registerForRemoteNotifications();
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
