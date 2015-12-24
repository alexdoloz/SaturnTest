//
//  ViewController.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import TSValidatedTextField


class LoginViewController: UIViewController {
    var manager: LoginManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        let message = Message(type: "LOGIN_CUSTOMER", sequenceId: "a29e4fd0-581d-e06b-c837-4f5f4be7dd18", dataObject: ["email" : "fb@bk.ru", "password" : "123123"])
        print("\(message.jsonData)")
        print("\(NSString(data: message.jsonData, encoding: NSUTF8StringEncoding)))")
        let testURLString = "ws://95.213.131.42:8080/customer-gateway/customer"
        let url = NSURL(string: testURLString)!
        manager = LoginManager(url: url)
        manager.performLogin(email: "fb@bk.ru", password: "123123") { error in
        }
    }
    
    @IBOutlet weak var emailTextField: TSValidatedTextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func performLogin(sender: AnyObject) {
        manager.performLogin(email: emailTextField.text!, password: passwordTextField.text!) { (error) -> Void in
            
        }
    }
}

