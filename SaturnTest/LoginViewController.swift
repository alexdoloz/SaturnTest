//
//  ViewController.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let message = Message(type: "LOGIN_CUSTOMER", sequenceId: "a29e4fd0-581d-e06b-c837-4f5f4be7dd18", dataObject: ["email" : "fb@bk.ru", "password" : "123123"])
        print("\(message.jsonData)")
        print("\(NSString(data: message.jsonData, encoding: NSUTF8StringEncoding)))")
    }
}

