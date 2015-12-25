//
//  LoginManager.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import Starscream


protocol LoginManagerDelegate: class {
    func loginManagerDidOpenConnection(manager: LoginManager)
    func loginManager(manager: LoginManager, didReceiveMessage message: Message)
    func loginManager(manager: LoginManager, didFailWithError error: NSError)
}

class LoginManager: NSObject, WebSocketDelegate {
// MARK: Constants
    let LOGIN_CUSTOMER = "LOGIN_CUSTOMER"
    let EMAIL_KEY = "email"
    let PASSWORD_KEY = "password"
    
// MARK: Variables
    private var socket: WebSocket!
    private var sequenceId: String
    
//    private var isSocketOpened = false
    
    weak var delegate: LoginManagerDelegate?
    
    init(url: NSURL) {
        socket = WebSocket(url: url)
        sequenceId = NSUUID().UUIDString
        socket.connect()
        super.init()
        socket.delegate = self
//        socket.onConnect = {
//
//        }
//        socket.onText = { text in
//            print("Got text : \(text)")
//        }
//        socket.onData = { data in
//            print("Got data: \(data)")
//        }
//        socket.onDisconnect = { error in
//            print("Error: \(error)")
//        }
    }
    
    deinit {
        socket.delegate = nil
        socket.disconnect()
    }
    
    func performLogin(email email: String, password: String) {
//        guard isSocketOpened else { return }
        guard socket.isConnected else { return }
        let message = Message(type: LOGIN_CUSTOMER, sequenceId: sequenceId, dataObject: [
            EMAIL_KEY : email,
            PASSWORD_KEY : password
        ])
        socket.writeString(message.jsonString)
    }
    
// MARK: WebSocketDelegate
    func websocketDidConnect(socket: WebSocket) {
        if delegate != nil {
            delegate!.loginManagerDidOpenConnection(self)
        }
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        if error != nil {
            if delegate != nil {
                delegate!.loginManager(self, didFailWithError: error!)
            }
            socket.connect()
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        if delegate != nil {
            if let message = Message(jsonData: text.dataUsingEncoding(NSUTF8StringEncoding)!) {
                delegate!.loginManager(self, didReceiveMessage: message)
            } else {
                let error = NSError(domain: "Text is not valid message", code: 111, userInfo: nil)
                delegate!.loginManager(self, didFailWithError: error)
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
    
    }
}
