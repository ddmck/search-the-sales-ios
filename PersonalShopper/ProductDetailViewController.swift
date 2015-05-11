//
//  ProductDetailViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 05/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire

class ProductDetailViewController: UIViewController {
  var data: Product!
  
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productDescription: UILabel!
  @IBOutlet weak var scroller: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    println(data.name)
    self.productName.text = data.name.capitalizedString
    getAndSetImage()
    getFullJSON()
    self.title = "£ \(data.price)"
    let rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveProduct:")
    navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: true)
    // Do any additional setup after loading the view.
  }
  
  func getFullJSON(){
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      
      let url = "http://localhost:3000/products/\(self.data.id).json"
      Alamofire.request(.GET, url)
        .responseJSON { (_, _, JSON, _) in
          
          println(JSON)
          if let response = JSON as? Dictionary<String, AnyObject> {
            println(response["description"])
            self.productDescription.text = response["description"]! as? String
            dispatch_async(dispatch_get_main_queue()) {
              self.scroller.contentSize = CGSizeMake(self.view.frame.width, self.productName.frame.height + self.productImage.frame.height + self.productDescription.frame.height + 100)
            }
          }
      }
    }
  }
  
  func getAndSetImage(){
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      
      let url = NSURL(string: self.data.image)
      if let imgdata = NSData(contentsOfURL: url!) { //make sure your image in this url does exist, otherwise unwrap in a if let check
        dispatch_async(dispatch_get_main_queue()) {
          
          self.productImage.image = UIImage(data: imgdata)
          self.scroller.contentSize = CGSizeMake(self.view.frame.width, self.productName.frame.height + self.productImage.frame.height + self.productDescription.frame.height + 100)
        }
      }
    }
    
  }
  
  func saveProduct(button: UIBarButtonItem){
    println("TODO: SET UP CODE TO SAVE FAVE")
    
    Alamofire.request(.POST, "http://localhost:3000/api/wishlist_items.json", parameters: ["params": ["product_id": self.data.id]])
      .responseJSON { (_,_,JSON,_) in
        println(JSON)
        
    }

    
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
