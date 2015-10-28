//
//  TestEvents.swift
//  Pinch
//
//  Created by Cameron Wu on 10/22/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import Foundation
import UIKit

var testEvents: [Event] = []

func generateTestEvents() {
    testEvents.append(Event(
        id: 0,
        org: Organization(
            id: 0,
            name: "Code for America",
            description: "Code for America believes government can work for the people, by the people in the 21st century.\n\nWe build open source technology and organize a network of people dedicated to making government services simple, effective, and easy to use.",
            causes: [.technology]
        ),
        name: "Hack Night",
        description: "All you need is your brain, your passion, and your openness when you come to Code for San Francisco's weekly Hack Night. We welcome all interested people, including residents, activitsts, business folk, designers, and developers. No need for tech experience of any kind!\n\nCode for San Francisco is a Code for America \"brigade\" or local chapter focused on improving San Francisco. You'll be surrounded by folks who are interested in working together to change The City for the better. We fix government services, create insightful visualizations from opened data, and engage people who may have been excluded from the economic boom in the Bay Area.  Come by to join an existing project (we need ALL types of skills - not just coders), to pitch your own project, or simply to experience the global movement to change the areas in which we live for the better.",
        startTime: NSDate(),
        endTime: NSDate(),
        addressStreet: "1234 Main St",
        addressCity: "San Francisco",
        addressState: "CA",
        addressZIP: "94103",
        location: Location(latitude: -144.0, longitude: 133.0),
        contactNumber: "123456",
        websiteURL: "www.codeforamerica.org"))
}