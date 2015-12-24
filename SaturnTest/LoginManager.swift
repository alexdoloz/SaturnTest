//
//  LoginManager.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit


class LoginManager: NSObject {
//    private var url: NSURL!
    private var socket: SRWebSocket!
    private var sequenceId: NSUUID!
    
    init(url: NSURL) {
        socket = SRWebSocket(URL: url)
        sequenceId = NSUUID()
    }
    
    func performLogin(email: String, password: String, completion: (NSError?) -> Void) {
        
    }
}
