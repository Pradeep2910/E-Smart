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
@IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    var keyboardHeight: Float = 0.0
    var currentFocusedTextField: UITextField!
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true

        schoolTextField.text = "S0001"
        userIdTextField.text = "S000100001"
        passwordTextField.text = "1992-05-02"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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

//MARK: - textfield delegate methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userIdTextField:
            userIdTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.becomeFirstResponder()
        case schoolTextField:
            schoolTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case schoolTextField,
             userIdTextField,
             passwordTextField:
            currentFocusedTextField = textField
            if keyboardHeight > 0 {
                self.scrollToMakeTextFieldVisible(currentFocusedTextField)
            }
        default:
            return
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case schoolTextField,
             userIdTextField,
             passwordTextField:
            loginScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        default:
            break
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = Float(keyboardSize.height)
            if currentFocusedTextField != nil {
                self.scrollToMakeTextFieldVisible(currentFocusedTextField)
            }
        }
    }
    
    func scrollToMakeTextFieldVisible(_ textField: UITextField) {
        switch textField {
        case schoolTextField,
             userIdTextField,
             passwordTextField:
            let textFieldHeight = textField.frame.size.height
            let expectedTextFieldFrame = Float(textFieldHeight + textField.frame.origin.y + 80.0)
            if expectedTextFieldFrame > keyboardHeight {
                loginScrollView.setContentOffset(CGPoint(x: 0, y: CGFloat(expectedTextFieldFrame - keyboardHeight)), animated: true)
            }
        default:
            return
        }
    }
}

