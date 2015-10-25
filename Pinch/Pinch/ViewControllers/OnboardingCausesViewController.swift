//
//  OnboardingCausesViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class OnboardingCausesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let skipButton = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.Plain, target: self, action: "performSegue")
        skipButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Lato-Bold", size: 15)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = skipButton
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
    
    func performSegue() {
        performSegueWithIdentifier("segueToFollowFriends", sender: nil)
    }

}
