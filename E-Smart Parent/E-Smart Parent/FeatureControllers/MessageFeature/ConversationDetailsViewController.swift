//
//  ConversationDetailsViewController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 19/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class ConversationDetailsViewController: UIViewController {
    @IBOutlet weak var messageTextview: UITextView!
@IBOutlet weak var messageview: UIView!
    @IBOutlet weak var historyTableview: UITableView!
    var loginDetails = LoginDetails()

    var conversationMessages = [ConversationMessages]()
    var isFromContacts = false
    var selectedConversation = ConversationList()
    var selectedContact = ContactDetails()

    var selectedUserID = ""
    var viewHasAppeared = false
    var selectedUserRole = ""
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        
        self.messageview.layer.borderWidth = 1.0
        self.messageview.layer.borderColor = UIColor.lightGray.cgColor
        self.messageview.layer.cornerRadius = 2.0
        self.historyTableview.rowHeight = UITableViewAutomaticDimension;
        self.historyTableview.estimatedRowHeight = 5000;
        
       self.viewDidLayoutSubviews()
        
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(keyboardWillShow),
                                                         name: NSNotification.Name.UIKeyboardWillShow,
                                                         object: nil)
        
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(keyboardWillHide),
                                                         name: NSNotification.Name.UIKeyboardWillHide,
                                                         object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
         viewHasAppeared = true
        if isFromContacts {
            self.getConversationDetailsForContact()
        }
        else{
        self.getConversationDetails()
            
        }
       self.viewDidLayoutSubviews()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         if !viewHasAppeared { self.scrollToBottom() }
    }
    func scrollToBottom() {
//        var yOffset : CGFloat = 0
//        if self.historyTableview.contentSize.height > self.historyTableview.bounds.size.height {
//            yOffset = self.historyTableview.contentSize.height - self.historyTableview.bounds.size.height
//        }
//        self.historyTableview.setContentOffset(CGPoint(x: 0, y: yOffset), animated: false)
//        
        guard conversationMessages.count > 0 else { return }
        
        
        let indexPath = NSIndexPath(row: conversationMessages.count - 1, section: 0)
        self.historyTableview.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: false)
        self.historyTableview.layoutIfNeeded()
    }
       // MARK: - Keyboard events
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey]
        {
            let keyboardSize = (keyboardFrame as AnyObject).cgRectValue.size
            self.viewBottomConstraint.constant = keyboardSize.height
            self.historyTableview.layoutIfNeeded()
          self.viewDidLayoutSubviews()
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.viewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func sendMessageTapped(_ sender: Any) {
        
        if messageTextview.text != "Enter message" && messageTextview.text.characters.count > 0 {
            self.sendMessageAPI()
        }
    }
    func notReachable() {
        //activityView?.stopAnimating()
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Internet Not Available", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}


extension ConversationDetailsViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let conversation = conversationMessages[indexPath.row]
        var identifier = ""
        if conversation.fromUserID == "S000100001" {
            identifier = "toUserCell"
        }
        else{
            identifier = "fromUserCell"
        }
        let conversationDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ConversationDetailTableviewCell
       
        conversationDetailCell.messageLabel.text = conversation.messageContent
        conversationDetailCell.dateLabel.text = conversation.messageDate;
        
       conversationDetailCell.messageLabel.layer.cornerRadius = 4
        conversationDetailCell.messageLabel.clipsToBounds = true
        return conversationDetailCell
    }
}

extension ConversationDetailsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }
}

extension ConversationDetailsViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter message" {
            textView.selectedRange = NSMakeRange(0, 0);
        }
     
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = "Enter message"
            textView.textColor = UIColor.lightGray
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == "Enter message" && text != "" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
        if textView.text == "Enter message" && text == "" {
           return false
        }
        if text == "" && textView.text.characters.count == 1 {
            textView.text = "Enter message"
            textView.textColor = UIColor.lightGray
            textView.isSelectable = true
             textView.selectedRange = NSMakeRange(0, 0);
            return false
        }
        textView.isSelectable = true
        return true
    }
}


//Webservice - Send Message
extension ConversationDetailsViewController{
    func sendMessageAPI(){
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = "S0001" as AnyObject?
        jsonParams["fromUserId"] = "S000100019" as AnyObject?
        jsonParams["fromUserRole"] = "S" as AnyObject?
        jsonParams["toUserId"] = self.selectedUserID as AnyObject?
        jsonParams["toUserRole"] = self.selectedUserRole as AnyObject?
        jsonParams["content"] = messageTextview.text as AnyObject?

//        self.activityView?.isHidden = false
//        self.activityView?.startAnimating()
        RequestBuilder().buildRequestSendMessageWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
//                self.activityView?.stopAnimating()
//                self.activityView?.isHidden = true
                if response != nil {
                    if let messageArray = response {
                  self.conversationMessages.append(contentsOf: messageArray)
                        self.historyTableview.reloadData()
                        self.view.endEditing(true)
                       self.viewDidLayoutSubviews()
                        self.messageTextview.text = "Enter message"
                        
                    }
                }
            } else {
//                self.activityView?.stopAnimating()
//                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }
    func getConversationDetails(){
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = selectedConversation.schoolID as AnyObject?
        jsonParams["fromUserId"] = selectedConversation.fromUserID as AnyObject?
        jsonParams["fromUserRole"] = selectedConversation.fromUserRole as AnyObject?
        jsonParams["toUserId"] = selectedConversation.toUserID as AnyObject?
        jsonParams["toUserRole"] = selectedConversation.toUserRole as AnyObject?
        //        self.activityView?.isHidden = false
        //        self.activityView?.startAnimating()
        RequestBuilder().buildRequestGetConversationHistoryWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                //                self.activityView?.stopAnimating()
                //                self.activityView?.isHidden = true
                if response != nil {
                    self.conversationMessages = response!
                    self.historyTableview.reloadData()
                    self.scrollToBottom()
                }
            } else {
                //                self.activityView?.stopAnimating()
                //                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }
    
    func getConversationDetailsForContact(){
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["fromUserId"] = loginDetails.studendID as AnyObject?
        jsonParams["fromUserRole"] = "S" as AnyObject?
        jsonParams["toUserId"] = selectedContact.userID as AnyObject?
        jsonParams["toUserRole"] = selectedContact.userRole as AnyObject?
        //        self.activityView?.isHidden = false
        //        self.activityView?.startAnimating()
        RequestBuilder().buildRequestGetConversationHistoryWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                //                self.activityView?.stopAnimating()
                //                self.activityView?.isHidden = true
                if response != nil {
                    self.conversationMessages = response!
                    self.historyTableview.reloadData()
                    self.scrollToBottom()
                }
            } else {
                //                self.activityView?.stopAnimating()
                //                self.activityView?.isHidden = true
                if error?.domain != "Not Reachable"{
                    let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.notReachable()
                }
            }
        })
    }

    

}
