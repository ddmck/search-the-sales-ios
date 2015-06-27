//
//  BasketViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 27/06/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {
  
  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let url = NSURL (string: "https://ub.io/basket?partnerDomain=bertie@searchthesales.com");
    let requestObj = NSURLRequest(URL: url!);
    webView.loadRequest(requestObj);
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    webView.reload()
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
