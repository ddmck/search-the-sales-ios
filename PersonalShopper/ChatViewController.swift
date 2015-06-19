//
//  ChatViewController.swift
//  PersonalShopper
//
//  Created by Donald McKendrick on 21/05/2015.
//  Copyright (c) 2015 Search the Sales LTD. All rights reserved.
//

import Foundation
import JSQMessagesViewController
import Locksmith
import Alamofire


class ChatViewController : JSQMessagesViewController {
  var messages: [JSQMessage] = []
  let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor(red: 142/255, green: 9/255, blue: 52/255, alpha: 1))
  let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
  let (userDetails, error) = Locksmith.loadDataForUserAccount("myUserAccount")

  
  override func viewDidLoad() {
    super.viewDidLoad()
    println(UIColor.jsq_messageBubbleLightGrayColor())
        // Do any additional setup after loading the view
    self.inputToolbar.contentView.leftBarButtonItem = nil
    senderId = userDetails!["id"]! as! String
    senderDisplayName = userDetails!["Name"]! as! String
    collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
    collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
    fetchMessages({
      messages in
      
      println(messages)
      
      for m in messages {
        self.messages.append(JSQMessage(senderId: m.senderID, senderDisplayName: m.senderName, date: m.date, text: m.message))
      }
      
      self.finishReceivingMessage()

    })
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
    println("hello")
    if (data.senderId == userDetails!["id"]! as! String) {
      return outgoingBubble
    } else {
      return incomingBubble
    }
  }
  
  override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
    let m = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
    self.messages.append(m)
    
    saveMessage(text, senderId)
    
    finishSendingMessage()
  }
}