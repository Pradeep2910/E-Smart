//
//  ContactsTableviewController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 21/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class ContactsTableviewController: UITableViewController {
    var contacts = [ContactDetails]()
    var loginDetails = LoginDetails()
    var filteredContacts = [ContactDetails]()
    var selectedContact = ContactDetails()
    let searchController = UISearchController(searchResultsController: nil)
    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getContactsAPI()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        // Setup the Scope Bar
        tableView.tableHeaderView = searchController.searchBar
        
    }
    func filterContentForSearchText(_ searchText: String) {
        filteredContacts = contacts.filter({( contact : ContactDetails) -> Bool in
            return contact.userID.lowercased().contains(searchText.lowercased())||contact.userName.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    func notReachable() {
        //activityView?.stopAnimating()
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Internet Not Available", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }


}

extension ContactsTableviewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension ContactsTableviewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


extension ContactsTableviewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredContacts.count
        }
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
         cell.textLabel?.font = UIFont(name: "Arial", size: 14.0)
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16.0)
        let contact: ContactDetails
        if searchController.isActive && searchController.searchBar.text != "" {
            contact = filteredContacts[indexPath.row]
        } else {
            contact = contacts[indexPath.row]
        }
        cell.textLabel?.text = contact.userName
        cell.detailTextLabel?.text = contact.userID
        return cell
    }
}

extension ContactsTableviewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            selectedContact = filteredContacts[indexPath.row]
        } else {
            selectedContact = contacts[indexPath.row]
        }
        let conversationDetails = self.storyBoard.instantiateViewController(withIdentifier: "conversationHistory") as! ConversationDetailsViewController
        conversationDetails.isFromContacts = true
        conversationDetails.selectedContact = self.selectedContact
        conversationDetails.loginDetails = self.loginDetails
        conversationDetails.selectedUserID = self.selectedContact.userID
        conversationDetails.selectedUserRole = self.selectedContact.userRole
        self.navigationController?.pushViewController(conversationDetails, animated: true)
        
    }
}


extension ContactsTableviewController{
    
    func getContactsAPI(){
        var jsonParams: [String : AnyObject] = [String : AnyObject]()
        jsonParams["schoolId"] = loginDetails.schoolID as AnyObject?
        jsonParams["userId"] = loginDetails.studendID as AnyObject?
        jsonParams["userRole"] = "S" as AnyObject?
        jsonParams["classId"] = loginDetails.classID as AnyObject?
        jsonParams["sectionId"] = loginDetails.sectionID as AnyObject?
        
        
        //        self.activityView?.isHidden = false
        //        self.activityView?.startAnimating()
        RequestBuilder().buildRequestGetContactsWithParams(params: jsonParams, completionHandler: {
            (success, response, error) in
            if success {
                //                self.activityView?.stopAnimating()
                //                self.activityView?.isHidden = true
                if response != nil {
                   
                    self.contacts = response!
                    self.tableView.reloadData()
                   
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
