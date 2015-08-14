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

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var emailInput: UITextField!
  
  @IBOutlet weak var passwordInput: UITextField!
  
  let progressHUD = ProgressHUD(text: "Signing In")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    progressHUD.hide()
    self.view.addSubview(progressHUD)
    passwordInput.delegate = self

    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    signIn()
    textField.resignFirstResponder()
    return true
  }
  
  @IBAction func SignInButtonPressed(sender: UIButton) {
    signIn()
  }
  
  func signIn() {
    progressHUD.show()
    Alamofire.request(.POST, "\(GlobalConstants.backendURL)api/auth/sign_in", parameters: ["email": emailInput.text, "password": passwordInput.text])
      .responseJSON { (_, res, JSON, _) in
        
        if let json = JSON as? Dictionary<String, AnyObject> {
          
          if let error = json["errors"] as? Array<String>{
            self.progressHUD.hide()
            var joiner = ", "
            var alert = UIAlertController(title: "Alert", message: joiner.join(error), preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
          } else {
            var id = json["data"]!["id"] as? NSNumber
            Locksmith.updateData([
              "Access-Token": res!.allHeaderFields["access-token"]! as! String,
              "Client": res!.allHeaderFields["client"]! as! String,
              "Uid": res!.allHeaderFields["uid"]! as! String,
              "Expiry": res!.allHeaderFields["expiry"]! as! String,
              "Name": json["data"]!["name"] as! String,
              "id": "\(id!)"
              ], forUserAccount: "myUserAccount")
            
            let (userDetails, error) = Locksmith.loadDataForUserAccount("myUserAccount")
            
            Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = [
              "Access-Token": userDetails!["Access-Token"]! as! String,
              "Client": userDetails!["Client"]! as! String,
              "Uid": userDetails!["Uid"]! as! String,
              "Expiry": userDetails!["Expiry"]! as! String
            ]
            
            Alamofire.request(.GET, "\(GlobalConstants.backendURL)api/wishlist_items.json")
              .responseJSON { (_,_,JSON,_) in
                
            }
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabVC = storyboard.instantiateViewControllerWithIdentifier("TabViewController") as! UIViewController
            
            self.presentViewController(tabVC, animated: true, completion: nil)
          }
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
