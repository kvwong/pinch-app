//
//  UserProfileViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets and Vars --------------------------------
    
    @IBOutlet weak var profileScrollView: UIScrollView!
    
    // Upcoming & Saved Event Tabs
    @IBOutlet weak var eventTabsView: UIView!
    @IBOutlet weak var upcomingEventsTab: UIButton!
    @IBOutlet weak var savedEventsTab: UIButton!
    @IBOutlet weak var activeTabView: UIView!

    // Upcoming & Saved Event Table View
    @IBOutlet weak var eventsTableView: UITableView!
    
    var eventTabsViewInitialY: CGFloat!
    
    // Overrides ---------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        // Scroll view setup
        profileScrollView.contentSize = CGSize(width: view.frame.width, height: 1800) // TO-DO: make height dynamic once table view pulls in data
        profileScrollView.delegate = self
        
        // Default to Upcoming tab on load
        switchTabs("Upcoming")
        upcomingEventsTab.setTitleColor(colorTextLight, forState: .Normal)
        savedEventsTab.setTitleColor(colorTextLight, forState: .Normal)
        upcomingEventsTab.setTitleColor(colorTextDark, forState: .Selected)
        savedEventsTab.setTitleColor(colorTextDark, forState: .Selected)
        
        // Save initial eventTabsView.frame.origin.y position
        eventTabsViewInitialY = eventTabsView.frame.origin.y
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //scrollView.contentSize = profileView.frame.size
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Scroll View Overrides ---------------------------
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // The following code block is buggy and doesn't work yet.
        /*if profileScrollView.contentOffset.y > 0 {
            print("profileScrollView.content.y offset is: \(profileScrollView.contentOffset.y)")
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }*/
        
        if profileScrollView.contentOffset.y > eventTabsViewInitialY {
           self.eventTabsView.frame.origin.y = profileScrollView.contentOffset.y
        } else {
            self.eventTabsView.frame.origin.y = eventTabsViewInitialY
        }
    }
    
    
    // Button Actions ----------------------------------
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
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
                self.activeTabView.frame.size.width = self.view.frame.width
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = self.view.frame.width/2
                }, completion: nil)
            loadUpcomingEvents()
        } else if tabToSwitchTo == "Saved" {
            print("Switching tab to Saved Events")
            upcomingEventsTab.userInteractionEnabled = true
            savedEventsTab.userInteractionEnabled = false
            upcomingEventsTab.selected = false
            savedEventsTab.selected = true
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = self.view.frame.width
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = self.view.frame.width/2
                self.activeTabView.frame.size.width = self.view.frame.width/2
                }, completion: nil)
            loadSavedEvents()
        } else {
            print("Invalid string \(tabToSwitchTo)")
        }
    }
    
    func loadUpcomingEvents() {
        print("Loading upcoming evnts...")
        // TO-DO: load here
    }
    
    func loadSavedEvents() {
        print("Loading saved evnts...")
        // TO-DO: load here
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        // TO-DO: return number of sections by upcoming time
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        // TO-DO: return number of rows per upcoming time
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UpcomingAndSavedEventsTableViewCell") as! UpcomingAndSavedEventsTableViewCell
        
        return cell
    }

}
