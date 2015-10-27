//
//  SignUpViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var field1: UIView!
    @IBOutlet weak var field2: UIView!
    @IBOutlet weak var field3: UIView!
    @IBOutlet weak var field4: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styles for text fields and button
        field1.layer.cornerRadius = buttonCornerRadius
        field2.layer.cornerRadius = buttonCornerRadius
        field3.layer.cornerRadius = buttonCornerRadius
        field4.layer.cornerRadius = buttonCornerRadius
        signUpButton.layer.cornerRadius = buttonCornerRadius
        
        firstNameField.attributedPlaceholder = NSAttributedString(string: "First Name",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        lastNameField.attributedPlaceholder = NSAttributedString(string: "Last Name",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        emailField.attributedPlaceholder = NSAttributedString(string: "Email",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
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
    
    @IBAction func didPressSignup(sender: UIButton) {
        
        if firstNameField.text == "" {
            let alertController = UIAlertController(title: "First Name Required", message: "Please enter your first name.", preferredStyle: .Alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        } else if emailField.text == "" {
            let alertController = UIAlertController(title: "Email Required", message: "Please enter your email address.", preferredStyle: .Alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
            
        } else if passwordField.text == "" {
            
            let alertController = UIAlertController(title: "Password Required", message: "Please enter a password.", preferredStyle: .Alert)
            
            // Create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // Add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        } else {
            self.performSegueWithIdentifier("segueToCauses", sender: nil)
        }
    }
    
    @IBAction func didPressCancelButton(sender: UIButton) {
        navigationController!.popViewControllerAnimated(true)
    }
    
}
