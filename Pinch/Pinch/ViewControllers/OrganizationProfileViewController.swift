//
//  OrganizationProfileViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class OrganizationProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var previousTab: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
        // TO-DO: return number of sections by upcoming time
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 0
        } else {
            return 8
            // TO-DO: return number of rows by upcoming time
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section < 2 {
            if indexPath.row == 0{
               let cell =  tableView.dequeueReusableCellWithIdentifier("NPOImageTableViewCell") as! NPOImageTableViewCell
                return cell
            }else {
                 let cell =  tableView.dequeueReusableCellWithIdentifier("NPOImageTableViewCell") as! NPOImageTableViewCell
                return cell
            }
            
        } else {
            
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
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
        let headerCell =  tableView.dequeueReusableCellWithIdentifier("NPOProfileTabsTableViewCell") as! NPOProfileTabsTableViewCell
        
        return headerCell
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
            return 48
            
        } else if section == 2 {
            return 0
            
        } else {
            return 0
        }
    }

    
}
