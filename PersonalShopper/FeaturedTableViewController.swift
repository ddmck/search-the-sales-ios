//
//  FeaturedTableViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 29/04/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire

class FeaturedTableViewController: UITableViewController {
  let brain = APIBrain.sharedInstance
  
  var products = Array<Product>()
  override func viewDidLoad() {
    super.viewDidLoad()
    


    fetchPageOfProducts()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func viewDidAppear(animated: Bool) {
    if (brain.changed) {
      brain.changed = false
      brain.page = 1
      products = Array<Product>()
      self.tableView.reloadData()
      fetchPageOfProducts()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return products.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as! ProductTableViewCell
    let product = products[indexPath.row]
    cell.nameLabel.text = product.name
    cell.priceLabel.text = "£ \(product.price)"
    cell.tag = indexPath.row
    cell.productImage.image = nil
    cell.productImage.alpha = 0
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      
      let url = NSURL(string: product.image)
      if let data = NSData(contentsOfURL: url!) { //make sure your image in this url does exist, otherwise unwrap in a if let check
        dispatch_async(dispatch_get_main_queue()) {
          let visibleCells = self.tableView.visibleCells()
          var visibleCellIds = visibleCells.map({$0.tag}) as Array<Int>
          visibleCellIds.append(visibleCellIds.last! + 1)
          visibleCellIds.append(visibleCellIds.last! + 1)
          println(visibleCellIds)
          
          println(cell.tag)
          if contains(visibleCellIds, cell.tag) {
            cell.productImage.image = UIImage(data: data)
            UIView.transitionWithView(cell.productImage,
              duration: 0.25,
              options: UIViewAnimationOptions.TransitionCrossDissolve,
              animations: { cell.productImage.alpha = 1 },
              completion: nil)
          }
          
        }
      }
    }
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10; // space b/w cells
  }

  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
    
    var whenToScroll = products.count - 5
    if whenToScroll == indexPath.row {
      println("I should load")
      fetchPageOfProducts()
    }
  }
  
  func fetchPageOfProducts() {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      var params = ["filters": self.brain.filters, "page": self.brain.page] as [String: AnyObject]
      if self.brain.searchString != "" {
        params["search_string"] = self.brain.searchString
      }
      Alamofire.request(.GET, "http://localhost:3000/products.json", parameters: params)
        .responseJSON { (_, _, JSON, _) in
          if let response = JSON as? Array<Dictionary<String, AnyObject>> {
//            println(response)
            self.brain.page += 1
            
            for p in response {
              let id = p["id"]! as! Int
              let name = p["name"]! as! String
              let price = (p["display_price"] as! NSString).doubleValue
              let image = p["image_url"]! as! String
              self.products.append(Product(id: id, name: name, price: price, image: image, sizes: []))
            }
            dispatch_async(dispatch_get_main_queue()) {
              self.tableView.reloadData()
            }
          }
      }
    }
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let cell = sender as? UITableViewCell {
      let i = self.tableView.indexPathForCell(cell)!.row
      if segue.identifier == "toProductDetail" {
        let vc = segue.destinationViewController as! ProductDetailViewController
        vc.hidesBottomBarWhenPushed = true
        vc.data = products[i] as Product
      }
    }
  }
  
}
