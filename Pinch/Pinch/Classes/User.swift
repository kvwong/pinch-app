//
//  User.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import Foundation

class User {
    
    // Constants
    let uid: Int
    
    // Variables
    var firstName: String
    var lastName: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    var gender: Gender
    var upcomingEvents: [Event]
    var savedEvents: [Event]
    var pastEvents: [Event]
    var causes: [Cause]
    var testimonials: [Testimonial]
    //var badges: [Badge]
    var orgs: [Organization]
    
    // Initializer
    init(uid: Int, firstName: String, lastName: String, gender: Gender) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.upcomingEvents = []
        self.savedEvents = []
        self.pastEvents = []
        self.causes = []
        self.testimonials = []
        //self.badges = []
        self.orgs = []
    }
    
}

enum Gender {
    case Male, Female, Unspecified
}

struct Testimonial {
    let eventID: Event!
    var testimonial: String!
}