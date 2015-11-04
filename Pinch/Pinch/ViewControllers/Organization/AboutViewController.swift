//
//  AboutViewController.swift
//  Pinch
//
//  Created by Jessie Chen on 11/1/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import Parse
import ParseUI

protocol TabTableViewController : UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView! { get set }
}

class AboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TabTableViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        let query = PFQuery(className: "Organization")
        query.includeKey("eve")
//        
//        let userImageFile = Organization["storyImage"] as PFFile
//        userImageFile.getDataInBackgroundWithBlock {
//            (imageData: NSData!, error: NSError!) -> Void in
//            if !error {
//                let image = UIImage(data:imageData)
//            }
//        }
//        tableView.estimatedRowHeight = 220
//        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell") as! StoryCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ProgramsCell") as! ProgramsCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("PhotosAndVideosCell") as! PhotosAndVideosCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
            
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderCell
        
        switch (section) {
        case 0:
            headerCell.headerLabel.text =  "OUR STORY"
        case 1:
            headerCell.headerLabel.text = "PROGRAMS"
        case 2:
            headerCell.headerLabel.text = "PHOTOS & VIDEOS"
        default:
            print("default")
        }
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 40
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat!
        
       
        
        if indexPath.section == 0 {
             var storycellHeight = defaults.integerForKey("storycell_height")
            height = CGFloat(storycellHeight)
        } else if indexPath.section == 1 {
            var programscellHeight = defaults.integerForKey("programscell_height")
            height = CGFloat(programscellHeight)
        }else {
            height = 450
        }
        
        return height
    }

    

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
