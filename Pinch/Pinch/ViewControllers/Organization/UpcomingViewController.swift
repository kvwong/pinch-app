//
//  UpcomingViewController.swift
//  Pinch
//
//  Created by Jessie Chen on 11/1/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TabTableViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var organizationProfileViewController: OrganizationProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileUpcomingAndSavedEventsTableViewCell") as! UserProfileUpcomingAndSavedEventsTableViewCell
        
        let event = testEvents[0]
        
        // TO-DO: download an image into cell.eventImageView.image
        cell.titleLabel.text = event.name
        cell.attendeeCountLabel.text = "\(event.attendees.count) people are going"
        
        // Adjusted description line-height
        var attrString: NSMutableAttributedString = NSMutableAttributedString(string: event.description)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 4
        attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attrString.length))
        cell.descriptionLabel.attributedText = attrString;
        return cell

        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 111.5
    }
    
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//  
//        let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileUpcomingAndSavedEventsTableViewCell") as! UserProfileUpcomingAndSavedEventsTableViewCell
//        
////        let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileUpcomingAndSavedEventsTableViewCell") as! UserProfileUpcomingAndSavedEventsTableViewCell
//        
//        let event = testEvents[0]
//        
//        // TO-DO: download an image into cell.eventImageView.image
//        cell.titleLabel.text = event.name
//        cell.attendeeCountLabel.text = "\(event.attendees.count) people are going"
//        
//        // Adjusted description line-height
//        var attrString: NSMutableAttributedString = NSMutableAttributedString(string: event.description)
//        var style = NSMutableParagraphStyle()
//        style.lineSpacing = 4
//        attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attrString.length))
//        cell.descriptionLabel.attributedText = attrString;
//        return cell
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
