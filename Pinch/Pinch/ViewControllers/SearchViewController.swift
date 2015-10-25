//
//  SearchViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import TTTAttributedLabel
import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchTermField: UITextField!
    @IBOutlet weak var searchLocationField: UITextField!
    @IBOutlet weak var causesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Search Term field style
        searchTermField.layer.masksToBounds = true
        searchTermField.layer.cornerRadius = 4.0
        searchTermField.leftView = UIImageView(image: UIImage(named: "icon_search_13x13"))
        searchTermField.leftView?.frame = CGRectMake(0, 0, 28, 28)
        searchTermField.leftView?.contentMode = UIViewContentMode.Center
        searchTermField.leftViewMode = UITextFieldViewMode.Always
        
        // Search Location field style
        searchLocationField.layer.masksToBounds = true
        searchLocationField.layer.cornerRadius = 4.0
        searchLocationField.leftView = UIImageView(image: UIImage(named: "icon_location_13x13"))
        searchLocationField.leftView?.frame = CGRectMake(0, 0, 28, 28)
        searchLocationField.leftView?.contentMode = UIViewContentMode.Center
        searchLocationField.leftViewMode = UITextFieldViewMode.Always
        
        // Causes table view
        causesTableView.delegate = self
        causesTableView.dataSource = self
        causesTableView.tableFooterView = UIView.init(frame: CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressBackButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cause.allValues.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCausesTableView") as! SearchCausesTableViewCell
        cell.causeButton.setTitle(Cause.allValues[indexPath.row].rawValue, forState: .Normal)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("Hi")
    }
}
