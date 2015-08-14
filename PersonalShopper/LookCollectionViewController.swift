//
//  LookCollectionViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 28/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit

var selectedLooks = [String]()

class LookCollectionViewController: UICollectionViewController {
  let reuseIdentifier = "LookCollectionViewCell"
  var looks: [Dictionary<String, AnyObject>] = [["name": "look-1", "image": "lookbooks-1", "selected": false], ["name": "look-2", "image": "lookbooks-2", "selected": false], ["name": "look-3", "image": "lookbooks-3", "selected": false], ["name": "look-4", "image": "lookbooks-4", "selected": false], ["name": "look-5", "image": "lookbooks-5", "selected": false], ["name": "look-6", "image": "lookbooks-6", "selected": false], ["name": "look-7", "image": "lookbooks-7", "selected": false], ["name": "look-8", "image": "lookbooks-8", "selected": false], ["name": "look-6", "image": "lookbooks-9", "selected": false]]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Register cell classes
    collectionView!.registerNib(UINib(nibName: "LookCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LookCollectionViewCell")

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
    return looks.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! LookCollectionViewCell
    let look = looks[indexPath.row]
    // Configure the cell as! String
    cell.imageView.image = UIImage(named: look["image"]! as! String)
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let cell = collectionView.cellForItemAtIndexPath(indexPath)
    println(indexPath)
    looks[indexPath.row]["selected"] = true
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
    looks[indexPath.row]["selected"] = false
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
    if (looks[indexPath.row]["selected"]! as! Bool == true) {
      let view = UIImageView(frame: CGRectMake(0, 0, 32, 32))
      view.image = UIImage(named: "selected")
      cell.addSubview(view)
    } 
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "finishedLooks" {
      selectedLooks = []
      for look in looks {
        if look["selected"] as! Bool == true {
          selectedLooks.append(look["name"] as! String)
        }
      }
      println(selectedLooks)
    }
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
