//
//  UserOrgsViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 11/5/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserOrgsViewController: UIViewController {

    @IBOutlet weak var orgsScrollView: UIScrollView!
    @IBOutlet weak var orgsContentView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orgsScrollView.contentSize = orgsContentView.image!.size
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
