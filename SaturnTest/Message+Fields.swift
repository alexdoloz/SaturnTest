//
//  Message+Fields.swift
//  SaturnTest
//
//  Created by Alexander on 26.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation

let ERROR_DESCRIPTION_KEY = "error_description"
let API_TOKEN_KEY = "api_token"
let API_TOKEN_EXPIRATION_KEY = "api_token_expiration_date"

extension Message {

    var errorString: String? {
        return dataObject[ERROR_DESCRIPTION_KEY] as? String
    }
    
    var apiToken: String? {
        return dataObject[API_TOKEN_KEY] as? String
    }
    
    var apiTokenExpirationDate: NSDate? {
        guard let expirationDateString = dataObject[API_TOKEN_EXPIRATION_KEY] as? String else { return nil }
        let dateFormatter = NSDateFormatter()
        let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        return dateFormatter.dateFromString(expirationDateString)
    }
}