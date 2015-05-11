//
//  SearchViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 05/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UISearchBarDelegate {
  let brain = APIBrain.sharedInstance
  
  @IBOutlet weak var searchInput: UISearchBar!
  @IBOutlet weak var genderPicker: UIPickerView!
  let genderData = [["name": "All", "id": "0"], ["name": "Mens", "id": "1"], ["name": "Womens", "id": "2"]] as [Dictionary<String,String>]
  let categoryData = [["name": "All", "id": "0"], ["name": "Shoes", "id": "1"], ["name": "Jackets", "id": "5"]] as [Dictionary<String,String>]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    Alamofire.request(.GET, "http://localhost:3000/api/wishlist_items.json")
      .responseJSON { (_,_,JSON,_) in
        println(JSON)
        
    }

    // Do any additional setup after loading the view.
    
    genderPicker.dataSource = self
    genderPicker.delegate = self
    searchInput.delegate = self
    searchInput.text = brain.searchString
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
  
  // MARK: - Deleagate and DataSources
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 {
      return genderData.count
    } else if component == 1 {
      return categoryData.count
    }
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    if component == 0 {
      return genderData[row]["name"]
    } else if component == 1 {
      return categoryData[row]["name"]
    }
    return genderData[row]["name"]
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      brain.filters["gender_id"] = genderData[row]["id"]!.toInt()
    } else if component == 1 {
      brain.filters["category_id"] = categoryData[row]["id"]!.toInt()
    }

    brain.changed = true
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    brain.searchString = searchInput.text
    brain.changed = true
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    self.navigationController!.popViewControllerAnimated(true)
  }
  
}
