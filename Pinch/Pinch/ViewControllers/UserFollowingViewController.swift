//
//  UserFollowingViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserFollowingViewController: UIViewController {
    
    @IBOutlet weak var followingScrollView: UIScrollView!
    @IBOutlet weak var followingContentView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        followingScrollView.contentSize = followingContentView.image!.size
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
