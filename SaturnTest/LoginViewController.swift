//
//  ViewController.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import TSValidatedTextField


class LoginViewController: UIViewController, LoginManagerDelegate {
    var manager: LoginManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginManager()
        setupEmailValidation()
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
    
    @IBOutlet weak var emailTextField: TSValidatedTextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func performLogin(sender: AnyObject) {
        manager.performLogin(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
// MARK: LoginManagerDelegate
    func loginManagerDidOpenConnection(manager: LoginManager) {
        print("connect!")
    }
    
    func loginManager(manager: LoginManager, didReceiveMessage message: Message) {
        print("message: \(message.jsonString)")
    }
    
    func loginManager(manager: LoginManager, didFailWithError error: NSError) {
        print("error: \(error)")
    }
}

