//
//  LogInViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var field1: UIView!
    @IBOutlet weak var field2: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling for text fields and button
        field1.layer.masksToBounds = true
        field1.layer.cornerRadius = 4.0
        field2.layer.masksToBounds = true
        field2.layer.cornerRadius = 4.0
        logInButton.layer.masksToBounds = true
        logInButton.layer.cornerRadius = 4.0
        
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
    
    @IBAction func didPressLogin(sender: UIButton) {
        
        if usernameField.text == "" {
            
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
            
            let alertController = UIAlertController(title: "Password Required", message: "Please enter your password.", preferredStyle: .Alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
   
        } else if self.passwordField.text == "password" {
            
            print("signing in")
            //thinkingIndicator.startAnimating()
            
            let alertController = UIAlertController(title: "Logging in...", message: nil, preferredStyle: .Alert)
            
            self.presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
                
                delay(2, closure: { () ->
                    () in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                    // self.thinkingIndicator.stopAnimating()
                    
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                    
                })
            }
        } else {
            
            print("signing in")
            //thinkingIndicator.startAnimating()
            
            let alertController = UIAlertController(title: "Logging in...", message: nil, preferredStyle: .Alert)
            
            self.presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
                
                delay(2, closure: { () ->
                    () in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                    //self.thinkingIndicator.stopAnimating()
                    
                    let alertController = UIAlertController(title: "Log In Failed", message: "Incorrect email or password.", preferredStyle: .Alert)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.presentViewController(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                })
            }
        }
    }

    @IBAction func didPressCancelButton(sender: UIButton) {
        navigationController!.popViewControllerAnimated(true)
    }
    
}
