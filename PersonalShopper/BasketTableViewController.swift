//
//  BasketTableViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 12/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire

class BasketTableViewController: UITableViewController {
  let basket = BasketBrain.sharedInstance
  var storesForDelivery = [Store]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(true)
    storesForDelivery = [Store]()
    println(getStoreIDs())
    getAllStoreInfo()
    self.tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    if section == 0 {
      return basket.items.count
    } else {
      return storesForDelivery.count
    }
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      var cell = tableView.dequeueReusableCellWithIdentifier("BasketCell", forIndexPath: indexPath) as! BasketItemTableViewCell
      let product = self.basket.items[indexPath.row].product
      cell.nameLabel.text = product.name
      cell.priceLabel.text = "£ \(product.price)"
      let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
      dispatch_async(dispatch_get_global_queue(priority, 0)) {
        
        let url = NSURL(string: product.image)
        if let data = NSData(contentsOfURL: url!) { //make sure your image in this url does exist, otherwise unwrap in a if let check
          dispatch_async(dispatch_get_main_queue()) {
            cell.basketImage.image = UIImage(data: data)
          }
        }
      }
      return cell
    } else if indexPath.section == 1 {
      var cell = tableView.dequeueReusableCellWithIdentifier("DeliveryCell", forIndexPath: indexPath) as! BasketDeliveryItemTableViewCell
      cell.storeLabel.text = storesForDelivery[indexPath.row].name + " \(storesForDelivery[indexPath.row].stdDeliveryPrice)"
      cell.optionsForPicker = ["Standard Delivery: £\(storesForDelivery[indexPath.row].stdDeliveryPrice)", "Express Delivery: £\(storesForDelivery[indexPath.row].expDeliveryPrice)"]
      return cell
    } else {
      var cell = tableView.dequeueReusableCellWithIdentifier("DeliveryCell", forIndexPath: indexPath) as! BasketDeliveryItemTableViewCell
      return cell
    }
  }
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! BasketTableHeaderCell
    headerCell.textLabel?.textColor = UIColor.blackColor()
    headerCell.contentView.backgroundColor = UIColor.whiteColor()
    switch (section) {
    case 0:
      headerCell.textLabel?.text = "Items"
    case 1:
      headerCell.textLabel?.text = "Delivery"
    default:
      headerCell.textLabel?.text = "Other"
    }
    
    return headerCell
  }
  
  
  func getStoreIDs() -> [Int] {
    var ids = [Int]()
    for basketItem in basket.items {
      ids.append(basketItem.product.storeID)
    }
    return NSSet(array: ids).allObjects as! [Int]
  }
  
  func getAllStoreInfo(){
    
    for store in self.getStoreIDs() {
      getStoreInfo(store)
    }
    self.tableView.reloadData()
    
  }
  
  func getStoreInfo(store:Int) {
    Alamofire.request(.GET, "\(GlobalConstants.backendURL)stores/\(store).json")
      .responseJSON { (_,_,JSON,_) in
        println(JSON)
        if let response = JSON as? Dictionary<String, AnyObject> {
          self.convertResponseToStore(response)
        }
      }
  }
  
  func convertResponseToStore(res: Dictionary<String, AnyObject>) {
    var id = res["id"]! as! Int
    var name = res["name"]! as! String
    var stdDeliveryPrice = res["standard_price"]! as! Double
    var expDeliveryPrice = res["express_price"]! as! Double
    var freeDeliveryThreshold = res["free_delivery_threshold"]! as! Double
    var str = Store(id: id, name: name, stdDeliveryPrice: stdDeliveryPrice, expDeliveryPrice: expDeliveryPrice, freeDeliveryThreshold: freeDeliveryThreshold)
    self.storesForDelivery.append(str)
    self.tableView.reloadData()
  }
  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return NO if you do not want the specified item to be editable.
  return true
  }
  */
  
  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  if editingStyle == .Delete {
  // Delete the row from the data source
  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
  } else if editingStyle == .Insert {
  // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
  }
  */
  
  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
  
  }
  */
  
  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
  // Return NO if you do not want the item to be re-orderable.
  return true
  }
  */
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */
  
}
