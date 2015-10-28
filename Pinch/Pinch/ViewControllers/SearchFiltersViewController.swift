//
//  SearchFiltersViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class SearchFiltersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var filtersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCancelButton(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func didPressApplyButton(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // TableView Functions -----------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.section)
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventSegmentedControlCell") as! SearchFiltersSegmentedControlTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventLengthCell") as! SearchFiltersEventLengthTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDistanceCell") as! SearchFiltersEventDistanceTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("EventDistanceCell") as! SearchFiltersEventDistanceTableViewCell
            return cell
        }
    }
    
}
