//
//  ViewController.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import TSValidatedTextField


class LoginViewController: UIViewController, LoginManagerDelegate, UITextFieldDelegate {
    var manager: LoginManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginManager()
        setupEmailValidation()
        addActionsToTextFields()
        updateLoginButtonAvailability()
    }
    
    func setupLoginManager() {
        let testURLString = "ws://95.213.131.42:8080/customer-gateway/customer"
        let url = NSURL(string: testURLString)!
        manager = LoginManager(url: url)
        manager.delegate = self
    }
    
    func setupEmailValidation() {
        emailTextField.regexpValidColor = UIColor.blackColor()
        emailTextField.regexpInvalidColor = UIColor.redColor()
        emailTextField.regexp = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: [])
    }
    
    func addActionsToTextFields() {
        let action = Selector("updateTextFields")
        emailTextField.addTarget(self, action: action, forControlEvents: .EditingChanged)
        passwordTextField.addTarget(self, action: action, forControlEvents: .EditingChanged)
    }
    
    func updateLoginButtonAvailability() {
        emailTextField.validate()
        loginButton.enabled = emailTextField.isValid && (passwordTextField.text! as NSString).length != 0
    }
    
    func showError(errorString: String) {
        errorLabel.text = errorString
        UIView.animateWithDuration(0.25) {
            self.errorView.alpha = 1.0
        }
    }
    
    func hideError() {
        UIView.animateWithDuration(0.25) {
            self.errorView.alpha = 0.0
        }
    }
    
    @IBOutlet weak var emailTextField: TSValidatedTextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func performLogin(sender: AnyObject) {
        manager.performLogin(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @IBOutlet weak var errorView: UIView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
// MARK: LoginManagerDelegate
    func loginManagerDidOpenConnection(manager: LoginManager) {
        print("connect!")
    }
    
    func loginManager(manager: LoginManager, didReceiveMessage message: Message) {
        if let errorString = message.errorString {
            showError(errorString)
        }
        print("message: \(message.jsonString)")
    }
    
    func loginManager(manager: LoginManager, didFailWithError error: NSError) {
        print("error: \(error)")
        showError(error.localizedDescription)
    }
    
// MARK: Text field actions
    func updateTextFields() {
        updateLoginButtonAvailability()
        hideError()
    }
}

