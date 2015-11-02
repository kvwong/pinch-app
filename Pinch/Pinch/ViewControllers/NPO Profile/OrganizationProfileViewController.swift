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
        
        tableView.estimatedRowHeight = 220
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
        // TO-DO: return number of sections by upcoming time
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 0
        }            // TO-DO: return number of rows by upcoming tim

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCellWithIdentifier("NPOImageTableViewCell") as! NPOImageTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
        }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
        let headerCell =  tableView.dequeueReusableCellWithIdentifier("NPOProfileTabsTableViewCell") as! NPOProfileTabsTableViewCell
        headerCell.selectionStyle = UITableViewCellSelectionStyle.None
        return headerCell
        } else {
            return nil
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat!
        
        if indexPath.section == 0 {
           height = 220
        } else {
            height = 0
        }
        
        print("height \(height)")
        return height
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 1000
            
        } else {
            return 0
        }
}
}


