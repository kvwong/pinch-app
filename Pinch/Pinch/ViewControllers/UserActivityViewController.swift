//
//  UserActivityViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/21/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserActivityViewController: UIViewController {

    @IBOutlet weak var activityScrollView: UIScrollView!
    @IBOutlet weak var activityImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityScrollView.contentSize = activityImageView.image!.size
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
