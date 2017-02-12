//
//  LoginViewController.swift
//  E-Smart Parent
//
//  Created by Pradeep A C on 14/01/17.
//  Copyright © 2017 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController,ServiceManagerDelegate{
    
    @IBOutlet weak var schoolTextField: UITextField!
    var loginDetails = LoginDetails()
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var loginActIndicator: UIActivityIndicatorView!

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true

        schoolTextField.text = "S0001"
        userIdTextField.text = "S000100001"
        passwordTextField.text = "1992-05-02"
    }
    @IBAction func loginTapped(_ sender: Any) {
        
        /*self.view.endEditing(true)
         if (loginEmailIDField.text?.isEmpty)! {
         loginErrorLabel.isHidden = false
         loginErrorLabel.text = "Please enter your username!!"
         } else if (loginPasswordField.text?.isEmpty)! {
         loginErrorLabel.isHidden = false
         loginErrorLabel.text = "Please enter your password!!"
         } else if (loginEmailIDField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")).characters.count == 0) {
         loginErrorLabel.isHidden = false
         loginErrorLabel.text = "Please enter valid username!!"
         } else if (loginPasswordField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")).characters.count == 0) {
         loginErrorLabel.isHidden = false
         loginErrorLabel.text = "Please enter valid password!!"
         } else if ((loginPasswordField.text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")).characters.count)! < 8) {
         loginErrorLabel.isHidden = false
         loginErrorLabel.text = "Password should be of minimum 8 characters!!"
         } else {*/
        self.makeLoginRequest()
        // }

        
        
    }
    
    
    //MARK: - Web service methods
    /// to make login request
    func makeLoginRequest() {
         var jsonParams: [String : AnyObject] = [String : AnyObject]()
         jsonParams["userId"] = userIdTextField.text as AnyObject?
         jsonParams["password"] = passwordTextField.text as AnyObject?
        jsonParams["userRole"] = "S" as AnyObject?
        jsonParams["schoolId"] = schoolTextField.text as AnyObject?
         self.loginActIndicator.isHidden = false
         self.loginActIndicator.startAnimating()
         RequestBuilder().buildRequestForLoginWithParams(params: jsonParams, completionHandler: {
         (success, response, error) in
         if success {
         self.loginActIndicator.stopAnimating()
         self.loginActIndicator.isHidden = true
         if response != nil {
         self.userIdTextField.text = ""
         self.passwordTextField.text = ""
            self.schoolTextField.text = ""
         //TODO: to move to home screen*/
            self.loginDetails = response!
        self.performSegue(withIdentifier: "moveToHomeScreen", sender: self)
         }
         } else {
            if response != nil {
                self.loginActIndicator.stopAnimating()
                self.loginActIndicator.isHidden = true
                guard let responseMessage = response?.loginResponse else {
                    return
                }
                
                let alert = UIAlertController(title: "Alert", message:responseMessage, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
            }
            else{
         self.loginActIndicator.stopAnimating()
         self.loginActIndicator.isHidden = true
            if error?.domain != "Not Reachable"{
            let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)

         //self.passwordTextField.text = ""
            }
            else{
                self.notReachable()
            }
            }
         }
         })
    }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToHomeScreen" {
            let viewController:ViewController = segue.destination as! ViewController
            
            viewController.loginDetails = self.loginDetails
            
        }
        
    }
    func notReachable() {
        loginActIndicator?.stopAnimating()
        let alert: UIAlertController = UIAlertController(title: "Error", message: "Internet Not Available", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
