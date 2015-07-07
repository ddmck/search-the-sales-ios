//
//  RecommendationsViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 03/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire

class RecommendationsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  var collectionView: UICollectionView?
  var recommendations = [Recommendation]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchRecommendations()
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    var frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - (44+20+49))
    collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    layout.itemSize = CGSize(width: collectionView!.frame.width , height: 200)
    collectionView!.dataSource = self
    collectionView!.delegate = self
    collectionView!.registerNib(UINib(nibName: "RecommendationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCell")
    
    collectionView!.backgroundColor = UIColor.whiteColor()
    collectionView!.contentOffset = CGPointMake(0, 0)
    self.view.addSubview(collectionView!)
    self.title = "Recommendations"
    
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recommendations.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecommendationCell", forIndexPath: indexPath) as! RecommendationCollectionViewCell
    let recommendation = recommendations[indexPath.row]
    cell.titleLabel.text = recommendation.title
    cell.fromLabel.text = "from \(recommendation.senderName)"
    let imageViews = [cell.image1, cell.image2, cell.image3]
    var counter = 0
    for recItem in recommendation.recommendationItems {
      var product = recItem.product
      var url = product.image
      var imageURL = NSURL(string: url)
      imageViews[counter].sd_setImageWithURL(imageURL)
      counter += 1
    }
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let recommendation = recommendations[indexPath.row]
    let vc = RecommendationItemsViewController()
    vc.data = recommendation
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 1
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
  func fetchRecommendations() {
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_async(dispatch_get_global_queue(priority, 0)) {
      
      Alamofire.request(.GET, "\(GlobalConstants.backendURL)api/recommendations.json")
        .responseJSON {(_,_,JSON,_) in
          println(JSON)
          if let response = JSON as? Array<Dictionary<String, AnyObject>> {
            for rec in response {
              var recommendation = Recommendation(title: rec["title"] as! String, recommendationItems: [], senderName: rec["sender_name"] as! String)
              var recItems = rec["recommendation_items"] as! Array<Dictionary<String, AnyObject>>
              for recItem in recItems {
                var prd = recItem["product"] as! Dictionary<String, AnyObject>
                let id = prd["id"]! as! Int
                let storeID = prd["store_id"]! as! Int
                let name = prd["name"]! as! String
                let brandName = prd["brand_name"]! as! String
                let price = (prd["display_price"] as! NSString).doubleValue
                let image = prd["image_url"]! as! String
                let url = prd["url"]! as! String
                var product = Product(id: id, storeID: storeID, name: name, brandName: brandName, price: price, image: image, sizes: [], url: url)
                recommendation.recommendationItems.append(RecommendationItem(description: recItem["description"] as! String, liked: nil, product: product))
              }
              self.recommendations.append(recommendation)
            }
            
          }
          dispatch_async(dispatch_get_main_queue()) {
            self.collectionView!.reloadData()
          }
      }
      
    }
  
  }
  
}
