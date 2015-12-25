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
    
    let API_TOKEN_STORAGE_KEY = "API_TOKEN"
    let API_TOKEN_EXPIRATION_DATE_STORAGE_KEY = "API_TOKEN_EXPIRATION_DATE"
    
// MARK: Variables
    var socket: WebSocket!
    var sequenceId: String
    
    var apiToken: String?
    var apiTokenExpirationDate: NSDate?
    
    weak var delegate: LoginManagerDelegate?
    
    init(url: NSURL) {
        socket = WebSocket(url: url)
        sequenceId = NSUUID().UUIDString
        socket.connect()
        super.init()
        socket.delegate = self
        loadToken()
    }
    
    deinit {
        socket.delegate = nil
        socket.disconnect()
    }
    
    func loadToken() {
        apiToken = (NSUserDefaults.standardUserDefaults().objectForKey(API_TOKEN_STORAGE_KEY) as? String)
        apiTokenExpirationDate = (NSUserDefaults.standardUserDefaults().objectForKey(API_TOKEN_EXPIRATION_DATE_STORAGE_KEY) as? NSDate)
    }
    
    func saveToken() {
        NSUserDefaults.standardUserDefaults().setObject(apiToken!, forKey: API_TOKEN_STORAGE_KEY)
        NSUserDefaults.standardUserDefaults().setObject(apiTokenExpirationDate!, forKey: API_TOKEN_EXPIRATION_DATE_STORAGE_KEY)
    }
    
    var hasFreshToken: Bool {
        guard apiToken != nil else { return false }
        guard let expirationDate = apiTokenExpirationDate else { return false }
        guard expirationDate.compare(NSDate()) == .OrderedDescending else {
            return false
        }
        return true
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
                self.apiToken = message.apiToken
                self.apiTokenExpirationDate = message.apiTokenExpirationDate
                if self.apiToken != nil && self.apiTokenExpirationDate != nil {
                    saveToken()
                }
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
