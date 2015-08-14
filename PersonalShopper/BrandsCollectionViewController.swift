//
//  BrandsCollectionViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 27/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

var selectedBrands = [String]()

class BrandsCollectionViewController: UICollectionViewController {
  let reuseIdentifier = "Cell"
  var brands: [Dictionary<String, AnyObject>] = [["name": "ASOS", "image": "asos", "selected": false],["name": "All Saints", "image": "allsaints", "selected": false], ["name": "French Connection", "image": "french-connection", "selected": false], ["name": "Gucci", "image": "gucci", "selected": false], ["name": "Isabel Marant", "image": "isabel-marant", "selected": false], ["name": "Louboutin", "image": "louboutin", "selected": false], ["name": "Marc Jacobs", "image": "marc-jacobs", "selected": false], ["name": "Michael Kors", "image": "michael-kors", "selected": false], ["name": "Reiss", "image": "reiss", "selected": false], ["name": "Topshop", "image": "topshop", "selected": false], ["name": "Urban Outfitters", "image": "urban-outfitters", "selected": false]]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    collectionView!.registerNib(UINib(nibName: "BrandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BrandCollectionViewCell")
    collectionView!.allowsMultipleSelection = true
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
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    //#warning Incomplete method implementation -- Return the number of sections
    return 1
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //#warning Incomplete method implementation -- Return the number of items in the section
    return brands.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BrandCollectionViewCell", forIndexPath: indexPath) as! BrandCollectionViewCell
    
    let brand = brands[indexPath.row]
    // Configure the cell
    
    cell.imageView.image = UIImage(named: brand["image"]! as! String)
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.cellForItemAtIndexPath(indexPath)
    brands[indexPath.row]["selected"] = true

    var view = UIImageView(frame: CGRectMake(0, 0, 0, 0))
    view.center = CGPointMake(16, 16)
    view.image = UIImage(named: "selected")
    cell!.addSubview(view)
    UIView.animateWithDuration(0.25, animations: {
      view.frame = CGRectMake(0, 0, 32, 32)
    })

  }
  
  override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    var cell = collectionView.cellForItemAtIndexPath(indexPath)
    var view = cell!.subviews.last! as! UIImageView
    brands[indexPath.row]["selected"] = false
    UIView.animateWithDuration(0.25, animations: {
      view.frame = CGRectMake(16, 16, 0, 0)
      
    })
    let delay = 0.25 * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue()) {
      cell?.subviews.last?.removeFromSuperview()
    }
  }
  
  override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    if cell.subviews.count == 2 {
      if let sv = cell.subviews.last {
        sv.removeFromSuperview()
      }
    }
    if (brands[indexPath.row]["selected"]! as! Bool == true) {
      let view = UIImageView(frame: CGRectMake(0, 0, 32, 32))
      view.image = UIImage(named: "selected")
      cell.addSubview(view)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "finishBrands" {
      println("in the the segue")
      selectedBrands = []
      for brand in brands {
        if brand["selected"] as! Bool == true {
          selectedBrands.append(brand["name"] as! String)
        }
      }
      println(selectedBrands)
    }
  }
  
//  override func collectionView(collectionView: UICollectionView,
//    viewForSupplementaryElementOfKind kind: String,
//    atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//      //1
//      switch kind {
//        //2
//      case UICollectionElementKindSectionHeader:
//        //3
//        let headerView =
//        collectionView.dequeueReusableSupplementaryViewOfKind(kind,
//          withReuseIdentifier: "TableHeader",
//          forIndexPath: indexPath) as! UICollectionReusableView
//        return headerView
//      default:
//        //4
//        assert(false, "Unexpected element kind")
//      }
//  }

  
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
