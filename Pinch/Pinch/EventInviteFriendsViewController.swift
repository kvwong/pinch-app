//
//  EventInviteFriendsViewController.swift
//  Pinch
//
//  Created by Kevin Wong on 10/21/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class EventInviteFriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Invite Friends"
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCancelButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
