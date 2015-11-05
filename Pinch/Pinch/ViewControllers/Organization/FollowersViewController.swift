//
//  FollowersViewController.swift
//  Pinch
//
//  Created by Jessie Chen on 11/1/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FollowersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TabTableViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [PFObject]!
    var user: PFObject!
    
    var organizationProfileViewController: OrganizationProfileViewController!
    var vcType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("SOMETHING")
        
        tableView.delegate = self
        tableView.dataSource = self
        vcType = "followers"
        
        // Format table view
        tableView.separatorColor = colorBorderLight
        tableView.separatorInset.left = 68
        tableView.tableFooterView = UIView.init(frame: CGRectZero)
        
        // Download Users from Parse
        let query = PFQuery(className:"_User")
        //query.includeKey("organization") // Include Organization class
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) users.")
                // Do something with the found objects
                if let objects = objects as? [PFObject]? {
                    for (index, object) in objects!.enumerate() {
                        print("\(index): \(object.objectId!)")
                        self.users.append(object)
                      
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        print("users AAA: \(users)")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowingTableViewCell") as! FollowingTableViewCell
        
     

        //print("user BBB: \(user)")
        print("indexPath.row: \(indexPath.row)")
        
       //cell.nameLabel.text = users[indexPath.row].valueForKey("firstName") as? String
     
        
        //cell.nameLabel.text = "Test ABCD"
        
        return cell
    }

    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
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
