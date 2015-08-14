//
//  ChatOnboardingViewController.swift
//  HowAbout
//
//  Created by Donald McKendrick on 23/07/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import Foundation
import JSQMessagesViewController
import Locksmith

class ChatOnboardingViewController: JSQMessagesViewController {
  
  var messages: [JSQMessage] = []
  let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor(red: 142/255, green: 9/255, blue: 52/255, alpha: 1))
  let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
  let (userDetails, error) = Locksmith.loadDataForUserAccount("myUserAccount")


  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view
    self.inputToolbar.contentView.leftBarButtonItem = nil
    senderId = userDetails!["id"]! as! String
    senderDisplayName = userDetails!["Name"]! as! String
    collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
    collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
    let m = JSQMessage(senderId: "1000020", senderDisplayName: "Alex", date: NSDate(), text: "Welcome to HowAbout!")
    self.messages.append(m)
    
    self.finishReceivingMessage()
    self.showTypingIndicator = true
    
    let delay = 1 * Double(NSEC_PER_SEC)
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(time, dispatch_get_main_queue()) {
      self.showTypingIndicator = false
      let n = JSQMessage(senderId: "1000020", senderDisplayName: "Alex", date: NSDate(), text: "How can i help you?")
      self.messages.append(n)
      
      self.finishReceivingMessage()
      self.showTypingIndicator = true

    }
    
    let delay2 = 2 * Double(NSEC_PER_SEC)
    let time2 = dispatch_time(DISPATCH_TIME_NOW, Int64(delay2))
    dispatch_after(time2, dispatch_get_main_queue()) {
      self.showTypingIndicator = false
      let o = JSQMessage(senderId: "1000020", senderDisplayName: "Alex", date: NSDate(), text: "Lets pick out the brands you like?")
      self.messages.append(o)
      
      self.finishReceivingMessage()
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewControllerWithIdentifier("BrandsCollectionVC") as! BrandsCollectionViewController
      self.presentViewController(vc, animated: true, completion: nil)
    }
    


    
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
    var data  = self.messages[indexPath.row]
    return data
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
    var data = self.messages[indexPath.row]
    if (data.senderId == userDetails!["id"]! as! String) {
      return outgoingBubble
    } else {
      return incomingBubble
    }
  }
  
  override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
    let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
    self.messages.append(m)
    
    finishSendingMessage()
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
    var data = self.messages[indexPath.row]
    if (data.senderId != userDetails!["id"]! as? String) {
      cell.textView.textColor = UIColor.blackColor()
    }
    return cell
  }


}
