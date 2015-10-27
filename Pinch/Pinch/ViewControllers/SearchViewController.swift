//
//  SearchViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import AHEasing
//import TTTAttributedLabel

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchFieldsView: UIView!
    @IBOutlet weak var searchTermField: UITextField!
    @IBOutlet weak var searchLocationField: UITextField!
    @IBOutlet weak var causesView: UIView!
    @IBOutlet weak var causesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial look before animating in
        searchFieldsView.frame.origin.y = -searchFieldsView.frame.height
        searchFieldsView.alpha = 0
        causesView.alpha = 0
        causesView.frame.origin.y = self.view.frame.height
        
        // Search Term field style
        searchTermField.layer.masksToBounds = true
        searchTermField.layer.cornerRadius = buttonCornerRadius
        searchTermField.leftView = UIImageView(image: UIImage(named: "icon_search_13x13"))
        searchTermField.leftView?.frame = CGRectMake(0, 0, 28, 28)
        searchTermField.leftView?.contentMode = UIViewContentMode.Center
        searchTermField.leftViewMode = UITextFieldViewMode.Always
        searchTermField.attributedPlaceholder = NSAttributedString(string: "Search",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        
        // Search Location field style
        searchLocationField.layer.masksToBounds = true
        searchLocationField.layer.cornerRadius = buttonCornerRadius
        searchLocationField.leftView = UIImageView(image: UIImage(named: "icon_location_13x13"))
        searchLocationField.leftView?.frame = CGRectMake(0, 0, 28, 28)
        searchLocationField.leftView?.contentMode = UIViewContentMode.Center
        searchLocationField.leftViewMode = UITextFieldViewMode.Always
        searchLocationField.attributedPlaceholder = NSAttributedString(string: "Location",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        
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
    
    override func viewDidAppear(animated: Bool) {
        searchTermField.becomeFirstResponder()
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            self.searchFieldsView.frame.origin.y = 20
            self.searchFieldsView.alpha = 1
            //self.causesView.frame.origin.y = 128
            self.causesView.alpha = 1
            }, completion: nil)
        
        // Custom animation for smoother effect (default Swift is too choppy)
        CATransaction.begin()
        CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
        self.causesView.frame.origin.y = 128
        let animatePosition = CAKeyframeAnimation.animationWithKeyPath("position", function: QuarticEaseOut, fromPoint: CGPoint(x: self.view.frame.width/2, y:self.view.frame.height + self.causesView.frame.height/2), toPoint: CGPoint(x: self.view.frame.width/2, y: 128.0 + self.causesView.frame.height/2)) as! CAAnimation
        let animateOpacity = CAKeyframeAnimation.animationWithKeyPath("opacity", function: LinearInterpolation, fromValue: 0, toValue: 1) as! CAAnimation
        animatePosition.delegate = self
        self.causesView.layer.addAnimation(animatePosition, forKey: "position")
        self.causesView.layer.addAnimation(animateOpacity, forKey: "opacity")
        CATransaction.commit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressBackButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        hideKeyboard()
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
        cell.causeButton.indexPath = indexPath
        cell.causeButton.addTarget(self, action: "chooseCause:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    // When a button is pressed in the table view, fill the search term field
    func chooseCause(sender: SearchCauseButton) {
        searchTermField.text = Cause.allValues[sender.indexPath!.row].rawValue
        hideKeyboard()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        searchTermField.resignFirstResponder()
        searchLocationField.resignFirstResponder()
    }
}
