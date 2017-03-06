//
//  ConversationListViewcontroller.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 18/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class ConversationListViewcontroller: UIViewController {
    var conversationLists = [ConversationList]()
    var loginDetails = LoginDetails()
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    var selectedConversation = ConversationList()
    
    override func viewDidLoad() {
         self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.title = "Conversations"
        loginDetails = Application.application.loginDetails
    }
    
    
    func notReachable() {
        //activityView?.stopAnimating()
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Internet Not Available", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }


    


}

extension ConversationListViewcontroller:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let conversationListCell = tableView.dequeueReusableCell(withIdentifier: "conversationListCell", for: indexPath) as! ConversationListTableviewCell
        let conversation = conversationLists[indexPath.row]
        conversationListCell.messageContent.text = conversation.messageContent
        conversationListCell.toUserId.text = conversation.toUserName
        conversationListCell.messageDate.text = conversation.messageDate;
        
        conversationListCell.messageCount.layer.cornerRadius = 12.5
        conversationListCell.messageCount.clipsToBounds = true
        return conversationListCell
    }
}

extension ConversationListViewcontroller: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedConversation = conversationLists[indexPath.row]
        let conversationDetails = self.storyBoard.instantiateViewController(withIdentifier: "conversationHistory") as! ConversationDetailsViewController
        conversationDetails.selectedConversation = self.selectedConversation
        conversationDetails.selectedUserID = self.selectedConversation.toUserID
        conversationDetails.selectedUserName = self.selectedConversation.toUserName
        conversationDetails.selectedUserRole = self.selectedConversation.toUserRole
        self.navigationController?.pushViewController(conversationDetails, animated: true)
        
    }
}

extension ConversationListViewcontroller {
        
   
}
