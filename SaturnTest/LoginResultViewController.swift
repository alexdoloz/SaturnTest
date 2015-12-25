//
//  LoginResultViewController.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class LoginResultViewController: UIViewController {
    var expirationDate: NSDate!
    let dateFormat = "dd.MM.yyyy HH:mm"
    let dateFormatter = NSDateFormatter()
    
    @IBOutlet weak var expirationDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = dateFormat
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        expirationDateLabel.text = dateFormatter.stringFromDate(expirationDate)
    }
}
