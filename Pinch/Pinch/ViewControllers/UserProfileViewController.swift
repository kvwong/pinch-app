//
//  UserProfileViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import Parse

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    // Upcoming & Saved Event Table View
    @IBOutlet weak var eventsTableView: UITableView!
<<<<<<< HEAD
    
    @IBOutlet weak var cardsView: UIView!
    
=======
>>>>>>> origin/master
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContent: UIView!
    
    let currentUser = PFUser.currentUser()
    
    //var eventTabsViewInitialY: CGFloat!
    
    // Overrides ---------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        eventsTableView.tableFooterView = UIView.init(frame: CGRectZero)
        
<<<<<<< HEAD
         scrollView.contentSize = cardsView.frame.size
        
        print(cardsView.frame.size)
=======
        scrollView.delegate = self
        scrollView.contentSize.width = scrollViewContent.frame.width + 32
        
        if currentUser != nil {
            // do stuff with the user
            print("Hello, I'm \(currentUser!["firstName"])")
            self.title = currentUser!["firstName"] as! String
        } else {
            // show the signup or login screen
        }
>>>>>>> origin/master
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
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    // Button Actions ----------------------------------
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressNonProfits(sender: UIButton) {
        performSegueWithIdentifier("segueToFollowing", sender: "Non-Profits")
    }
    
    @IBAction func didPressFollowing(sender: UIButton) {
        performSegueWithIdentifier("segueToFollowing", sender: "Following")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? UserFollowingViewController {
            if sender as? String == "Non-Profits" {
                destination.title = "Non-Profits"
            } else {
                destination.title = "Following"
            }
        }
    }
    
    
    // Scroll View Overrides ---------------------------
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if eventsTableView.contentOffset.y > 0 {
            print("eventsTableView.content.y offset is: \(eventsTableView.contentOffset.y)")
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
                row.nameLabel.text = currentUser!["firstName"] as! String
                row.locationLabel.text = "\(currentUser!["city"] as! String), \(currentUser!["state"] as! String)"
                row.bioLabel.text = currentUser!["bio"] as! String
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
