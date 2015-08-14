//
//  ProductsViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 08/06/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire

class ProductsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {
  
  let formatter = NSNumberFormatter()
  var collectionView: UICollectionView?
  let brain = APIBrain.sharedInstance
  var products = Array<Product>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
    formatter.locale = NSLocale(localeIdentifier: "en_GB")
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = true;
    let searchBar = UISearchBar(frame: CGRectMake(-5.0, 0.0, 320.0, 44.0))
    searchBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    let searchBarView = UIView(frame: CGRectMake(0.0, 0.0, 310.0, 44.0))
    searchBarView.autoresizingMask = UIViewAutoresizing.allZeros
    searchBar.delegate = self
//    searchBar.alpha = 0.5
    searchBar.backgroundColor = nil
//    searchBar.barStyle = .White
    searchBar.searchBarStyle = .Minimal

    let textInput = searchBar.valueForKey("searchField") as? UITextField
    textInput?.textColor = UIColor.whiteColor()
    searchBarView.addSubview(searchBar)
    self.navigationItem.titleView = searchBarView
    
    fetchPageOfProducts()
    // Do any additional setup after loading the view, typically from a nib.
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var frame = CGRectMake(0, 0, self.view.bounds.width, (self.view.bounds.height - (44+20+49)))
    collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    layout.itemSize = CGSize(width: (collectionView!.frame.width / 2) - 15, height: (collectionView!.frame.height / 2) - 20)
    collectionView!.dataSource = self
    collectionView!.delegate = self
    collectionView!.registerNib(UINib(nibName: "NewProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

    collectionView!.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(collectionView!)
  }
  
  
  override func viewDidAppear(animated: Bool) {
    if (brain.changed) {
      brain.changed = false
      brain.page = 1
      products = Array<Product>()
      self.collectionView!.reloadData()
      fetchPageOfProducts()
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
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return products.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! NewProductCollectionViewCell
    let product = products[indexPath.row]
    cell.nameLabel.text = product.brandName.uppercaseString
    
    
    cell.priceLabel.text = formatter.stringFromNumber(product.price)
    let url = NSURL(string: product.image)
    
    cell.imageView.sd_setImageWithURL(url)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    var whenToScroll = products.count - 5
    if whenToScroll == indexPath.row {
      println("I should load")
      fetchPageOfProducts()
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let product = products[indexPath.row]
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    let vc = storyboard.instantiateViewControllerWithIdentifier("ProductDetailVC") as! ProductDetailViewController
    vc.hidesBottomBarWhenPushed = true
    vc.data = product as Product
    self.navigationController?.pushViewController(vc, animated: true)
//    self.presentViewController(vc, animated: true, completion: nil)
  }
  
//  func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//    let reusableView: UICollectionReusableView
//    
//    if (kind == UICollectionElementKindSectionFooter) {
//      
//    }
//    
//    return reusableView
//  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    brain.searchString = searchBar.text
    brain.changed = true
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if (brain.changed) {
      brain.changed = false
      brain.page = 1
      products = Array<Product>()
      self.collectionView!.reloadData()
      fetchPageOfProducts()
    }
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    self.navigationItem.titleView?.subviews.first?.resignFirstResponder()

  }
  
  func fetchPageOfProducts() {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      var params = ["filters": self.brain.filters, "page": self.brain.page, "origin": "app"] as [String: AnyObject]
      if self.brain.searchString != "" {
        params["search_string"] = self.brain.searchString
      }
      Alamofire.request(.GET, "\(GlobalConstants.backendURL)products.json", parameters: params)
        .responseJSON { (_, _, JSON, _) in
          if let response = JSON!["products"] as? Array<Dictionary<String, AnyObject>> {
            //            println(response)
            self.brain.page += 1
            
            for p in response {
              let id = p["id"]! as! Int
              let storeID = p["store_id"]! as! Int
              let name = p["name"]! as! String
              let brandName = p["brand_name"]! as! String
              let price = (p["display_price"] as! NSString).doubleValue
              let image = p["image_url"]! as! String
              let url = p["url"]! as! String
              
              self.products.append(Product(id: id, storeID: storeID, name: name, brandName: brandName, price: price, image: image, sizes: [], url: url))
            }
            dispatch_async(dispatch_get_main_queue()) {
              self.collectionView!.reloadData()
            }
          }
      }
    }
  }

  
}
