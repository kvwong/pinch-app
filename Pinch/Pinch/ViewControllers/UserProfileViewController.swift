//
//  UserProfileViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Upcoming & Saved Event Table View
    @IBOutlet weak var eventsTableView: UITableView!
    
    //var eventTabsViewInitialY: CGFloat!
    
    // Overrides ---------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        // Save initial eventTabsView.frame.origin.y position
        //eventTabsViewInitialY = eventTabsView.frame.origin.y
        
        // Format table view
        //eventsTableView.separatorColor = colorBorderLight
        //eventsTableView.separatorInset.left = 80
        eventsTableView.tableFooterView = UIView.init(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Button Actions ----------------------------------
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // Scroll View Overrides ---------------------------
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if eventsTableView.contentOffset.y > 0 {
            print("eventsTableView.content.y offset is: \(eventsTableView.contentOffset.y)")
            self.title = "Annabel" // TO-DO: dynamically input user name
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
        }
        
        /*
        if eventsTableView.contentOffset.y + (navigationController?.navigationBar.frame.origin.y)! + (navigationController?.navigationBar.frame.height)! > eventTabsViewInitialY {
           self.eventTabsView.frame.origin.y = profileScrollView.contentOffset.y + (navigationController?.navigationBar.frame.origin.y)! + (navigationController?.navigationBar.frame.height)!
        } else {
            self.eventTabsView.frame.origin.y = eventTabsViewInitialY
        }*/
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
        // TO-DO: return number of sections by upcoming time
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 0
        } else {
            return 8
            // TO-DO: return number of rows per upcoming time
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section < 2 {
            if indexPath.row == 0 {
                let row = tableView.dequeueReusableCellWithIdentifier("UserProfileDetailsTableViewCell") as! UserProfileDetailsTableViewCell
                return row
            } else {
                let row = tableView.dequeueReusableCellWithIdentifier("UserProfileMenuTableViewCell") as! UserProfileMenuTableViewCell
                return row
            }
        } else {
            let row = tableView.dequeueReusableCellWithIdentifier("UserProfileUpcomingAndSavedEventsTableViewCell") as! UserProfileUpcomingAndSavedEventsTableViewCell
            let event = testEvents[0]
            
            // TO-DO: download an image into cell.eventImageView.image
            row.titleLabel.text = event.name
            row.attendeeCountLabel.text = "\(event.attendees.count) people are going"
            
            // Adjusted description line-height
            var attrString: NSMutableAttributedString = NSMutableAttributedString(string: event.description)
            var style = NSMutableParagraphStyle()
            style.lineSpacing = 4
            attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attrString.length))
            row.descriptionLabel.attributedText = attrString;
            
            /*
            profileScrollView.contentSize = CGSize(width: view.frame.width, height: profileScrollView.contentInset.top + eventsTableView.frame.origin.y + eventsTableView.frame.height)
            */
            
            return row
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = tableView.dequeueReusableCellWithIdentifier("UserProfileEventTabsTableViewCell") as! UserProfileEventTabsTableViewCell
            return header
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return nil
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat!
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                height = 220
            } else if indexPath.row == 1 {
                height = 184
            }
        } else {
            height = 111.5
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44
        } else if section == 2 {
            return 44
        } else {
            return 0
        }
    }

}
