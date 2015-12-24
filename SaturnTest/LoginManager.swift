//
//  LoginManager.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit


class LoginManager: NSObject, SRWebSocketDelegate {
// MARK: Constants
    let LOGIN_CUSTOMER = "LOGIN_CUSTOMER"
    let EMAIL_KEY = "email"
    let PASSWORD_KEY = "password"
    
// MARK: Variables
    private var socket: SRWebSocket!
    private var sequenceId: String
    
    private var isSocketOpened = false
    
    init(url: NSURL) {
        socket = SRWebSocket(URL: url)
        sequenceId = NSUUID().UUIDString
        super.init()
        socket.delegate = self
        socket.open()
        
    }
    
    deinit {
        socket.delegate = nil
        socket.close()
    }
    
    func performLogin(email email: String, password: String, completion: (NSError?) -> Void) {
        guard isSocketOpened else { return }
        let message = Message(type: LOGIN_CUSTOMER, sequenceId: sequenceId, dataObject: [
            EMAIL_KEY : email,
            PASSWORD_KEY : password
        ])
        socket.send(message.jsonData)
    }
    
// MARK: SRWebSocketDelegate
    func webSocketDidOpen(webSocket: SRWebSocket!) {
        isSocketOpened = true
        print("Socket did open")
    }
    
    func webSocket(webSocket: SRWebSocket!, didFailWithError error: NSError!) {
        print("Socket failed with error: \(error)")
    }
    
    func webSocket(webSocket: SRWebSocket!, didReceiveMessage message: AnyObject!) {
        print("Got message! \(message)")
    }
    
    func webSocket(webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        print("Code: \(code)")
    }
}
