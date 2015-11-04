//
//  NPOProfileTabsTableViewCell.swift
//  
//
//  Created by Jessie Chen on 10/29/15.
//
//

import UIKit

class NPOProfileTabsTableViewCell: UITableViewCell {

    @IBOutlet weak var aboutTab: UIButton!
    @IBOutlet weak var upcomingTab: UIButton!
    @IBOutlet weak var followersTab: UIButton!
    @IBOutlet weak var activeTabView: UIView!

    var organizationProfileViewController: OrganizationProfileViewController!
    
    var previousTab = "Upcoming"
    
    override func awakeFromNib() {
        super.awakeFromNib()

        aboutTab.setTitleColor(colorTextLight, forState: .Normal)
        upcomingTab.setTitleColor(colorTextLight, forState: .Normal)
        followersTab.setTitleColor(colorTextLight, forState: .Normal)
        aboutTab.setTitleColor(colorTextDark, forState: .Selected)
        upcomingTab.setTitleColor(colorTextDark, forState: .Selected)
        followersTab.setTitleColor(colorTextDark, forState: .Selected)
        
    }

    @IBAction func didPressAbout(sender: AnyObject) {
        switchTabs("About")
    }
    
    @IBAction func didPressUpcoming(sender: AnyObject) {
        switchTabs("Upcoming")
    }

    @IBAction func didPressFollowing(sender: AnyObject) {
        switchTabs("Followers")
    }
    
    func loadUpcoming() {
    organizationProfileViewController.activeViewController = organizationProfileViewController.upcomingViewController
        
//        print("Loading upcoming events...")
//        //call viewWillLoad
//        upcomingViewController.willMoveToParentViewController(organizationProfileViewController)
//        
//        upcomingViewController.view.frame = displayView.frame
//        displayView.addSubview(upcomingViewController.view)
//        
//        //call viewDidLoad. Put in animation completion bloc
//        upcomingViewController.didMoveToParentViewController(organizationProfileViewController)
    }
    
    func loadAbout() {
        organizationProfileViewController.activeViewController = organizationProfileViewController.aboutViewController
        
//        print("Loading about page...")
//        //call viewWillLoad
//        aboutViewController.willMoveToParentViewController(organizationProfileViewController)
//        
//        aboutViewController.view.frame = displayView.frame
//        displayView.addSubview(aboutViewController.view)
//        
//        //call viewDidLoad. Put in animation completion bloc
//        aboutViewController.didMoveToParentViewController(organizationProfileViewController)

    }
    
    func loadFollowers() {
        
        organizationProfileViewController.activeViewController = organizationProfileViewController.followersViewController
        
        print("Loading followers list...")
//        //call viewWillLoad
//        followersViewController.willMoveToParentViewController(organizationProfileViewController)
//        
//        followersViewController.view.frame = displayView.frame
//        displayView.addSubview(followersViewController.view)
//        
//        //call viewDidLoad. Put in animation completion bloc
//        followersViewController.didMoveToParentViewController(organizationProfileViewController)

    }
    
    func switchTabs(tabToSwitchTo: String) {
        var situation: Int!
        
        if tabToSwitchTo == "Upcoming" && previousTab == "About" {
            situation = 0
        }else if tabToSwitchTo == "Upcoming" && previousTab == "Followers" {
            situation = 1
        }else if tabToSwitchTo == "About" && previousTab == "Upcoming" {
            situation = 2
        }else if tabToSwitchTo == "Followers" && previousTab == "Upcoming" {
            situation = 3
        }else if tabToSwitchTo == "About" && previousTab == "Followers" {
            situation = 4
        }else if tabToSwitchTo == "Followers" && previousTab == "About" {
            situation = 5
        }
        
        switch situation {
        case 0:
            print("case 0")
            print("Switching to Upcoming from About")
            upcomingTab.userInteractionEnabled = false
            followersTab.userInteractionEnabled = true
            aboutTab.userInteractionEnabled = true
            upcomingTab.selected = true
            aboutTab.selected = false
            followersTab.selected = false
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3*2
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = UIScreen.mainScreen().bounds.width/3
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3
                }, completion: nil)
            loadUpcoming()

            previousTab = "Upcoming"
        case 1:
            print("case 1")
            print("Switching to Upcoming from Followers")
            upcomingTab.userInteractionEnabled = false
            followersTab.userInteractionEnabled = true
            aboutTab.userInteractionEnabled = true
            upcomingTab.selected = true
            followersTab.selected = false
            aboutTab.selected = false
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = UIScreen.mainScreen().bounds.width/3
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3*2
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3
                }, completion: nil)
            loadUpcoming()
            previousTab = "Upcoming"
        case 2:
            print("case 2")
            print("Switching to About from Upcoming")
            upcomingTab.userInteractionEnabled = true
            followersTab.userInteractionEnabled = true
            aboutTab.userInteractionEnabled = false
            upcomingTab.selected = false
            followersTab.selected = false
            aboutTab.selected = true
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = 0
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3*2
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3
                }, completion: nil)
            loadAbout()

            previousTab = "About"
        case 3:
            print("case 3")
            print("Switching to Followers from Upcoming")
            upcomingTab.userInteractionEnabled = true
            followersTab.userInteractionEnabled = false
            aboutTab.userInteractionEnabled = true
            upcomingTab.selected = false
            followersTab.selected = true
            aboutTab.selected = false
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3*2
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = UIScreen.mainScreen().bounds.width/3 * 2
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3
                }, completion: nil)
            loadFollowers()

            previousTab = "Followers"
        case 4:
            print("case 4")
            print("Switching to About from Followers")
            upcomingTab.userInteractionEnabled = true
            followersTab.userInteractionEnabled = true
            aboutTab.userInteractionEnabled = false
            upcomingTab.selected = false
            followersTab.selected = false
            aboutTab.selected = true
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = 0
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3*3
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3
                }, completion: nil)
            loadAbout()

            previousTab = "About"
        case 5:
            print("case 5")
            print("Switching to Followers from About")
            upcomingTab.userInteractionEnabled = true
            followersTab.userInteractionEnabled = false
            aboutTab.userInteractionEnabled = true
            upcomingTab.selected = false
            followersTab.selected = true
            aboutTab.selected = false
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3*3
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = UIScreen.mainScreen().bounds.width/3 * 2
                self.activeTabView.frame.size.width = UIScreen.mainScreen().bounds.width/3
                }, completion: nil)
            loadFollowers()

            previousTab = "Followers"
        default:
            print("default")
        }
    
        
}

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

