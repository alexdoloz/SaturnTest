//
//  Message.swift
//  SaturnTest
//
//  Created by Alexander on 24.12.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation

struct Message {
    var type: String
    var sequenceId: NSUUID
    var data: Dictionary<String, AnyObject>

    init?(jsonString: String) {
        return nil
    }
    
    init(type: String, sequenceId: NSUUID, data: Dictionary<String, AnyObject>) {
        self.type = type
        self.sequenceId = sequenceId
        self.data = data
    }
    
    var jsonString: String {
        return ""
    }
}