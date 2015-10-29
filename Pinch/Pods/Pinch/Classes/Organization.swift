//
//  Organization.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import Foundation

class Organization {
    
    // Constants
    let id: Int
    
    // Variables
    var name: String
    var description: String
    var causes: [Cause]
    
    // Initializer
    init(id: Int, name: String, description: String, causes: [Cause]) {
        self.id = id
        self.name = name
        self.description = description
        self.causes = causes
    }
    
}