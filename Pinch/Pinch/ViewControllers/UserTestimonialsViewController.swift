//
//  UserTestimonialsViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/21/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserTestimonialsViewController: UIViewController {

    @IBOutlet weak var testimonialsScrollView: UIScrollView!
    @IBOutlet weak var testimonialsImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testimonialsScrollView.contentSize = testimonialsImageView.image!.size
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
