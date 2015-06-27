//
//  ProductDetailViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 05/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import Alamofire


class ProductDetailViewController: UIViewController {
  var data: Product!
  
  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var productName: UILabel!
  @IBOutlet weak var productDescription: UILabel!
  @IBOutlet weak var scroller: UIScrollView!
  @IBAction func addToBasketPressed(sender: UIButton) {
    println("pressed")
    let webview = UIWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
    let url = NSURL (string: "http://ub.io/bertie@searchthesales.com/\(data.url)");
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let vc = storyboard.instantiateViewControllerWithIdentifier("ProductBasketVC") as! ProductBasketViewController

    vc.url = NSURL (string: "http://ub.io/bertie@searchthesales.com/\(data.url)")
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func sizeButtonPressed(sender: UIButton) {
    println("pressed")
    var sizesForPicker = Array<String>()
    
    for size in data.sizes! {
      sizesForPicker.append(size["name"] as! String)
    }
    
    var sizePicker = ActionSheetStringPicker(title: "Sizes", rows: sizesForPicker, initialSelection: 0, doneBlock: {
      picker, index, value in
      
      println("value = \(value)")
      println("index = \(index)")
      println("picker = \(picker)")
      
      return
    }, cancelBlock: {
      ActionStringCancelBlock in return
    }, origin: sender.superview!.superview)
    sizePicker.setDoneButton(UIBarButtonItem(title: "Add To Basket", style: UIBarButtonItemStyle.Plain, target: self, action: "Done:"))
    sizePicker.showActionSheetPicker()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    println(data.name)
    self.productName.text = data.name.capitalizedString
    getAndSetImage()
    getFullJSON()
    self.title = data.name
    let rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveProduct:")
    navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: true)
    // Do any additional setup after loading the view.
  }
  
  func getFullJSON(){
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      
      let url = "\(GlobalConstants.backendURL)products/\(self.data.id).json"
      Alamofire.request(.GET, url)
        .responseJSON { (_, _, JSON, _) in
          
          println(JSON)
          if let response = JSON as? Dictionary<String, AnyObject> {
            println(response["sizes"])
            self.data.sizes  = response["sizes"]! as? Array<Dictionary<String, AnyObject>>
            println(response["description"])
            self.productDescription.text = response["description"]! as? String
            dispatch_async(dispatch_get_main_queue()) {
              self.scroller.contentSize = CGSizeMake(self.view.frame.width, self.productName.frame.height + self.productImage.frame.height + self.productDescription.frame.height + 300)
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
    
    Alamofire.request(.POST, "\(GlobalConstants.backendURL)api/wishlist_items.json", parameters: ["params": ["product_id": self.data.id]])
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
