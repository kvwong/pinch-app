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
    
    var aboutViewController: AboutViewController!
    var upcomingViewController: UpcomingViewController!
    var followersViewController: FollowersViewController!
    
    var activeViewController: TabTableViewController! {
        didSet {
            if tableView != nil {
                tableView.reloadData()
            }
        }
    }
    
    var tabsView: NPOProfileTabsTableViewCell!
    var tabsViewInitialY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 220
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = false
        
        
        tabsView = tableView.dequeueReusableCellWithIdentifier("NPOProfileTabsTableViewCell") as! NPOProfileTabsTableViewCell
        tabsView.organizationProfileViewController = self
        tabsView.selectionStyle = UITableViewCellSelectionStyle.None
        
        tabsViewInitialY = 220
        tabsView.frame.origin.y = tabsViewInitialY - tableView.contentOffset.y
        view.addSubview(tabsView)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        aboutViewController = storyboard.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
        aboutViewController.view.layoutIfNeeded()
        upcomingViewController = storyboard.instantiateViewControllerWithIdentifier("UpcomingViewController") as! UpcomingViewController
        upcomingViewController.view.layoutIfNeeded()
        followersViewController = storyboard.instantiateViewControllerWithIdentifier("FollowersViewController") as! FollowersViewController
        followersViewController.view.layoutIfNeeded()
        
        activeViewController = aboutViewController
        //activeViewController = upcomingViewController

    }
    
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if tableView.contentOffset.y > 220 {
            tabsView.frame.origin.y = 0
        } else {
            tabsView.frame.origin.y = tabsViewInitialY - tableView.contentOffset.y
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2 + activeViewController.numberOfSectionsInTableView!(activeViewController.tableView)
        // TO-DO: return number of sections by upcoming time
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 0
        } else {
            return activeViewController.tableView(activeViewController.tableView, numberOfRowsInSection: section - 2)
            
//            return aboutViewController.tableView(aboutViewController.tableView, numberOfRowsInSection: section + 1)
        }            // TO-DO: return number of rows by upcoming tim
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 {
            let cell =  tableView.dequeueReusableCellWithIdentifier("NPOImageTableViewCell") as! NPOImageTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        } else {
            let contentIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section - 2)
//            let contentIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section + 1)
            let cell = activeViewController.tableView(activeViewController.tableView, cellForRowAtIndexPath: contentIndexPath)
            //cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section <= 1 {
            return nil
        } else {
          
            return activeViewController.tableView!(activeViewController.tableView, viewForHeaderInSection: section - 2)
            
            //            return aboutViewController.tableView(aboutViewController.tableView, numberOfRowsInSection: section + 1)
        }
        
//        if section == 1 {
//            let headerCell =  tableView.dequeueReusableCellWithIdentifier("NPOProfileTabsTableViewCell") as! NPOProfileTabsTableViewCell
//            headerCell.selectionStyle = UITableViewCellSelectionStyle.None
//            headerCell.organizationProfileViewController = self
//            return headerCell
//        } else {
//            return nil
//        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat!
        
        if indexPath.section == 0 {
            height = 220
        } else if indexPath.section == 1 {
            height = 0
        }else {
            let contentIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section - 2)
            height = activeViewController.tableView!(activeViewController.tableView, heightForRowAtIndexPath: contentIndexPath)
        }
        
        print("height \(height)")
        return height
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
            
        } else if section == 1 {
            return 44
        }else {
        
            return activeViewController.tableView!(activeViewController.tableView, heightForHeaderInSection: section - 2)
        }
    }
}


