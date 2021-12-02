//
//  Activity.swift
//  PursuApp
//
//  Created by Robert Miller on 03.12.2021.
//

import Foundation

class Activity {
    
    let activity: String
    let accessibility: Int
    let type: String
    let participants: Int
    let price: Int
    let key: Int
    
    init(activity: String, accessibility: Int, type: String, participants: Int, price: Int, key: Int) {
        self.activity = activity
        self.accessibility = accessibility
        self.type = type
        self.participants = participants
        self.price = price
        self.key = key
    }
    
}
