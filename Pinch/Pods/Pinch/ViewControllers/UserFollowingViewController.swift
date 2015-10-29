//
//  UserFollowingViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserFollowingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var followingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        followingTableView.delegate = self
        followingTableView.dataSource = self
        
        // Format table view
        followingTableView.separatorColor = colorBorderLight
        followingTableView.separatorInset.left = 68
        followingTableView.tableFooterView = UIView.init(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowingTableViewCell") as! FollowingTableViewCell
        
        return cell
    }

}
