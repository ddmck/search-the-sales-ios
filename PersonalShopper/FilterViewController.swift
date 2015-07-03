//
//  FilterViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 17/06/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class FilterViewController: UIViewController {
  let brain = APIBrain.sharedInstance
  
  @IBOutlet weak var categoryButtonLabel: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func categoriesButtonPressed(sender: AnyObject) {
    var categoriesForPicker = Array<String>()
    
    for cat in brain.categories {
      categoriesForPicker.append(cat["name"] as! String)
    }
    
    var categoryPicker = ActionSheetStringPicker(title: "Categories", rows: categoriesForPicker, initialSelection: 0, doneBlock: {
        picker, index, value in
      self.categoryButtonLabel.setTitle(value as! String!, forState: UIControlState.Normal)
      var cat = self.brain.categories[index]
      self.brain.filters["category_id"] = cat["id"]
      self.brain.changed = true
        return
      }, cancelBlock: {
        ActionStringCancelBlock in return
      }, origin: sender.superview)
    categoryPicker.setDoneButton(UIBarButtonItem(title: "Select", style: UIBarButtonItemStyle.Plain, target: self, action: "Done:"))
    categoryPicker.showActionSheetPicker()
  }
  
  @IBAction func brandsButtonPressed(sender: UIButton) {
    var brandsForPicker = Array<String>()
    
    for brand in brain.brands {
      brandsForPicker.append(brand["name"] as! String)
    }
    
    var brandPicker = ActionSheetStringPicker(title: "Brands", rows: brandsForPicker, initialSelection: 0, doneBlock: {
      picker, index, value in
      sender.setTitle(value as! String!, forState: UIControlState.Normal)
      var brand = self.brain.brands[index]
      self.brain.filters["brand_id"] = brand["id"]
      self.brain.changed = true
      return
      }, cancelBlock: {
        ActionStringCancelBlock in return
      }, origin: sender.superview)
    brandPicker.setDoneButton(UIBarButtonItem(title: "Select", style: UIBarButtonItemStyle.Plain, target: self, action: "Done:"))
    brandPicker.showActionSheetPicker()
  }
  
  @IBAction func colorsButtonPressed(sender: UIButton) {
    var colorsForPicker = Array<String>()
    
    for color in brain.colors {
      colorsForPicker.append(color["name"] as! String)
    }
    
    var colorPicker = ActionSheetStringPicker(title: "Colors", rows: colorsForPicker, initialSelection: 0, doneBlock: {
      picker, index, value in
      sender.setTitle(value as! String!, forState: UIControlState.Normal)
      var color = self.brain.colors[index]
      self.brain.filters["color_id"] = color["id"]
      self.brain.changed = true
      return
      }, cancelBlock: {
        ActionStringCancelBlock in return
      }, origin: sender.superview)
    colorPicker.setDoneButton(UIBarButtonItem(title: "Select", style: UIBarButtonItemStyle.Plain, target: self, action: "Done:"))
    colorPicker.showActionSheetPicker()
  }
  
  @IBAction func gendersButtonPressed(sender: UIButton) {
    var gendersForPicker = Array<String>()
    
    for gender in brain.genders {
      gendersForPicker.append(gender["name"] as! String)
    }
    
    var genderPicker = ActionSheetStringPicker(title: "Genders", rows: gendersForPicker, initialSelection: 0, doneBlock: {
      picker, index, value in
      sender.setTitle(value as! String!, forState: UIControlState.Normal)
      var gender = self.brain.genders[index]
      self.brain.filters["gender_id"] = gender["id"]
      self.brain.changed = true
      return
      }, cancelBlock: {
        ActionStringCancelBlock in return
      }, origin: sender.superview)
    genderPicker.setDoneButton(UIBarButtonItem(title: "Select", style: UIBarButtonItemStyle.Plain, target: self, action: "Done:"))
    genderPicker.showActionSheetPicker()
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
