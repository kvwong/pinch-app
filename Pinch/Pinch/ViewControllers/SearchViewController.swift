//
//  SearchViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTermField: UITextField!
    @IBOutlet weak var searchLocationField: UITextField!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
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
