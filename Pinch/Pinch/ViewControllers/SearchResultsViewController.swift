//
//  SearchResultsViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchTermField: UITextField!
    @IBOutlet weak var searchLocationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign delegates
        searchTermField.delegate = self
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
            self.searchTermField.frame.size.width = 343
            self.searchTermField.frame.origin.x = 16
            self.searchTermField.frame.origin.y = 64
            self.searchLocationField.frame.size.width = 343
            self.searchLocationField.frame.origin.x = 16
            self.searchLocationField.frame.origin.y = 100
            }, completion: nil)
        
        return true
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
