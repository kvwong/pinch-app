//
//  Event.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import Foundation

class Event {
    
    // Constants
    let id: Int
    let org: Organization
    
    // Variables
    var name: String
    var description: String
    var startTime: NSDate
    var endTime: NSDate
    var addressStreet: String
    var addressCity: String
    var addressState: String
    var addressZIP: String
    var contactNumber: String
    var websiteURL: String
    var attendees: [User]
    
    // Initializer
    init(
        id: Int,
        org: Organization,
        name: String,
        description: String,
        startTime: NSDate,
        endTime: NSDate,
        addressStreet: String,
        addressCity: String,
        addressState: String,
        addressZIP: String,
        contactNumber: String,
        websiteURL: String
        )
    {
        self.id = id
        self.org = org
        self.name = name
        self.description = description
        self.startTime = startTime
        self.endTime = endTime
        self.addressStreet = addressStreet
        self.addressCity = addressCity
        self.addressState = addressState
        self.addressZIP = addressZIP
        self.contactNumber = contactNumber
        self.websiteURL = websiteURL
        self.attendees = []
    }
    
}