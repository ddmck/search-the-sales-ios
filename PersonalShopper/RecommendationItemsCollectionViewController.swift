//
//  RecommendationItemsCollectionViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 05/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

let reuseIdentifier = "RecommendationItemCell"

class RecommendationItemsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  var collectionView: UICollectionView?
  var data: Recommendation?
  let formatter = NSNumberFormatter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
    formatter.locale = NSLocale(localeIdentifier: "en_GB")
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - (44+20+49))
    collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    layout.itemSize = CGSize(width: collectionView!.frame.width , height: (collectionView!.frame.height / 2))
    collectionView!.dataSource = self
    collectionView!.delegate = self
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    collectionView!.registerNib(UINib(nibName: "RecommendationItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationItemCell")
    collectionView!.backgroundColor = UIColor.whiteColor()
    self.view.addSubview(collectionView!)
    self.title = data!.title
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
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  }
  */
  
  // MARK: UICollectionViewDataSource
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    //#warning Incomplete method implementation -- Return the number of sections

    return 1
  }
  
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //#warning Incomplete method implementation -- Return the number of items in the section
    var items = data!.recommendationItems
    return items.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecommendationItemCell", forIndexPath: indexPath) as! RecommendationItemCollectionViewCell
    var items = data!.recommendationItems
    let product = items[indexPath.row]
    println(product)
    let productDetails = product.product
    // Configure the cell
    cell.descriptionView.text = "\"\(product.description)\""
    cell.nameLabel.text = product.product.name.capitalizedString
    cell.brandLabel.text = product.product.brandName
    
    cell.priceLabel.text = formatter.stringFromNumber(product.product.price)
    var url = productDetails.image
    var imageURL = NSURL(string: url)
    cell.imageView.sd_setImageWithURL(imageURL)
    
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let product = data?.recommendationItems[indexPath.row].product
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("ProductDetailVC") as! ProductDetailViewController
    vc.hidesBottomBarWhenPushed = true
    vc.data = product
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 1
  }
  
  // MARK: UICollectionViewDelegate
  
  /*
  // Uncomment this method to specify if the specified item should be highlighted during tracking
  override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment this method to specify if the specified item should be selected
  override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return true
  }
  */
  
  /*
  // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
  override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
  return false
  }
  
  override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
  
  }
  */
  
}
