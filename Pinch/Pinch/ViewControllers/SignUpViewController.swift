//
//  SignUpViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import Parse
import SwiftValidator
import UIView_Shake

class SignUpViewController: UIViewController, ValidationDelegate {
    
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var textFieldsView: UIView!
    @IBOutlet weak var field1: UIView!
    @IBOutlet weak var field2: UIView!
    @IBOutlet weak var field3: UIView!
    @IBOutlet weak var field4: UIView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var formInitialY: CGFloat! // Store initial position of form
    let validator = Validator() // Validation for text fields
    
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
        
        formInitialY = formView.frame.origin.y
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        validator.registerField(emailField, rules: [EmailRule()])
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
            self.field1.shake()
        }
        if lastNameField.text == "" {
            self.field2.shake()
        }
        if emailField.text == "" {
            self.field3.shake()
        }
        if passwordField.text == "" {
            self.field4.shake()
        }
        if firstNameField.text != "" && lastNameField.text != "" && emailField.text != "" && passwordField.text != "" {
            validator.validate(self)
        }
    }
    
    func validationSuccessful() {
        print("Signing up...")
        var user = PFUser()
        user.username = emailField.text // We don't support usernames, so we use the email address as username
        user.password = passwordField.text
        user.email = emailField.text
        user["firstName"] = firstNameField.text
        user["lastName"] = lastNameField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                if error.code == 202 || error.code == 203 {
                    let alertController = UIAlertController(title: "Email Address Taken", message: "It looks like someone already has that email address. Please try another.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            } else {
                // Hooray! Let them use the app now.
                self.performSegueWithIdentifier("segueToCauses", sender: nil)
            }
        }
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        for (field, error) in validator.errors {
            if error.errorMessage == "Must be a valid email address" {
                let alertController = UIAlertController(title: "Invalid Email Address", message: "Oops! A typo maybe? Please enter a valid email address.", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didPressCancelButton(sender: UIButton) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    
    // Keyboard Hide/Show Functions --------------------
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        let kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            self.formView.frame.origin.y = self.formInitialY
            }, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            self.formView.frame.origin.y = (self.view.frame.height - kbSize.height)/2 - self.formView.frame.height/2 + UIApplication.sharedApplication().statusBarFrame.size.height/2
            }, completion: nil)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
