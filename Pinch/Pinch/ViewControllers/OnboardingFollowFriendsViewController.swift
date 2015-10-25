//
//  OnboardingFollowFriendsViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class OnboardingFollowFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navbarView: UIView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var facebookTab: UIButton!
    @IBOutlet weak var contactsTab: UIButton!
    @IBOutlet weak var activeTabView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var peopleTabsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientLayerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gradientLayerView.layerGradient()
        let topColor = UIColorFromRGB("FFFFFF", alpha: 0)
        let bottomColor = UIColorFromRGB("FFFFFF", alpha: 1)
        
        //let topColor = UIColor.redColor()
        //let bottomColor = UIColor.blueColor()
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0 , 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = gradientLayerView.bounds
        gradientLayerView.layer.insertSublayer(gradientLayer, atIndex: 0)
    
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }
    
    @IBAction func didPressFacebookTab(sender: UIButton) {
        switchTabs("facebook")
    }
    
    @IBAction func didPressContactsTab(sender: UIButton) {
        switchTabs("contacts")
    }
    
    func switchTabs(tabToSwitchTo: String) {
        if tabToSwitchTo == "facebook" {
            print("Switching tab to Facebook")
            facebookTab.userInteractionEnabled = false
            contactsTab.userInteractionEnabled = true
            facebookTab.selected = true
            contactsTab.selected = false
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = 0
                self.activeTabView.frame.size.width = self.view.frame.width
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = self.view.frame.width/2
                }, completion: nil)
        } else if tabToSwitchTo == "contacts" {
            print("Switching tab to Contacts")
            facebookTab.userInteractionEnabled = true
            contactsTab.userInteractionEnabled = false
            facebookTab.selected = false
            //contactsTab.selected = true
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.size.width = self.view.frame.width
                }, completion: nil)
            UIView.animateWithDuration(0.2, delay: 0.15, options: .CurveEaseInOut, animations: { () -> Void in
                self.activeTabView.frame.origin.x = self.view.frame.width/2
                self.activeTabView.frame.size.width = self.view.frame.width/2
                }, completion: nil)
        } else {
            print("Invalid string \(tabToSwitchTo)")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PeopleCell", forIndexPath: indexPath) as! PeopleCell
        cell.profileImageView.layer.cornerRadius = 20.0
        cell.profileImageView.clipsToBounds = true
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
