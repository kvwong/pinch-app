//
//  LogInViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressLogin(sender: UIButton) {
        
        
        
        if usernameField.text == ""{
            
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
        }else if passwordField.text == ""{
            
            let alertController = UIAlertController(title: "Password Required", message: "Please enter a password for your Pinch account.", preferredStyle: .Alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            presentViewController(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
            
            
        } else if self.passwordField.text == "password"{
            
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
        }else {
            
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
    
    
    
    
}
