//
//  UserProfileEventTabsTableViewCell.swift
//  Pinch
//
//  Created by Cameron Wu on 10/24/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserProfileEventTabsTableViewCell: UITableViewCell {
    
    // Upcoming & Saved Event Tabs
    @IBOutlet weak var upcomingEventsTab: UIButton!
    @IBOutlet weak var savedEventsTab: UIButton!
    @IBOutlet weak var activeTabView: UIView!
    @IBOutlet weak var dividerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Default to Upcoming tab on load
        switchTabs("Upcoming")
        upcomingEventsTab.setTitleColor(colorTextLight, forState: .Normal)
        savedEventsTab.setTitleColor(colorTextLight, forState: .Normal)
        upcomingEventsTab.setTitleColor(colorTextDark, forState: .Selected)
        savedEventsTab.setTitleColor(colorTextDark, forState: .Selected)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // Button Actions ----------------------------------
    
    @IBAction func didPressUpcomingEventsTab(sender: UIButton) {
        switchTabs("Upcoming")
    }
    
    @IBAction func didPressSavedEventsTab(sender: UIButton) {
        switchTabs("Saved")
    }
    
    
    // Upcoming and Saved Events -----------------------
    
    func switchTabs(tabToSwitchTo: String) {
        if tabToSwitchTo == "Upcoming" {
            print("Switching tab to Upcoming Events")
            upcomingEventsTab.userInteractionEnabled = false
            savedEventsTab.userInteractionEnabled = true
            upcomingEventsTab.selected = true
            savedEventsTab.selected = false
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = 0
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/2
                }, completion: nil)
            loadUpcomingEvents()
        } else if tabToSwitchTo == "Saved" {
            print("Switching tab to Saved Events")
            upcomingEventsTab.userInteractionEnabled = true
            savedEventsTab.userInteractionEnabled = false
            upcomingEventsTab.selected = false
            savedEventsTab.selected = true
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = UIScreen.mainScreen().bounds.width/2
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/2
                }, completion: nil)
            loadSavedEvents()
        } else {
            print("Invalid string \(tabToSwitchTo)")
        }
    }
    
    func loadUpcomingEvents() {
        print("Loading upcoming events...")
        // TO-DO: load here
    }
    
    func loadSavedEvents() {
        print("Loading saved events...")
        // TO-DO: load here
    }
}
