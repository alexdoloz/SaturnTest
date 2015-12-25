//
//  Message.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Message {
// MARK: JSON Keys
    let TYPE_KEY = "type"
    let SEQUENCE_ID_KEY = "sequence_id"
    let DATA_KEY = "data"

// MARK: Properties
    var type: String
    var sequenceId: String
    var dataObject: Dictionary<String, AnyObject>

// MARK: Initializers
    init(type: String, sequenceId: String, dataObject: Dictionary<String, AnyObject>) {
        self.type = type
        self.sequenceId = sequenceId
        self.dataObject = dataObject
    }
    
    init?(jsonData: NSData) {
        let json = JSON(data: jsonData)
        guard let type = json[TYPE_KEY].string else { return nil }
        guard let sequenceId = json[SEQUENCE_ID_KEY].string else { return nil }
        guard let dataObject = json[DATA_KEY].dictionaryObject else { return nil }
        self.type = type
        self.sequenceId = sequenceId
        self.dataObject = dataObject
    }
    
// MARK: JSON Data
    var jsonData: NSData {
        let jsonDictionary = [
            TYPE_KEY: type,
            SEQUENCE_ID_KEY: sequenceId,
            DATA_KEY: dataObject
        ]
        let data = try! NSJSONSerialization.dataWithJSONObject(jsonDictionary, options: [])
        return data
    }
    
    var jsonString: String {
        return NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
    }
}