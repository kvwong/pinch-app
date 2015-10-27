//
//  OnboardingCausesViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import JCTagListView

class OnboardingCausesViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var tagListView: JCTagListView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gradientLayerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
        scrollView.contentSize = CGSizeMake(340, 600)
        
        let topColor = UIColorFromRGB("FFFFFF", alpha: 0)
        let bottomColor = UIColorFromRGB("FFFFFF", alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0 , 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = gradientLayerView.bounds
        gradientLayerView.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        tagListView.canSeletedTags = true
        tagListView.tagColor = UIColor.blueColor()
        tagListView.tagCornerRadius = 10
        
        tagListView.tags = ["Advocacy & Human Rights", "Animals", "Arts & Culture", "Board Development", "Children & Youth", "Crisis Support", "Disaster Relief", "Education & Literacy", "Emergency & Safety", "Employment", "Environment", "Faith", "Health & Medicine", "Homeless & Housing", "Hunger", "Immigration & Refugees", "International", "Justice & Legal", "LGBT", "Media & Broadcasting", "Disabilities", "Politics", "Race & Ethnicity", "Seniors", "Sports & Recreation", "Technology", "Veterans & Military Families", "Women"]
        
        tagListView.setCompletionBlockWithSeleted { (index) -> Void in
            
            print("Index: \(index)")
        }
        

        let skipButton = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.Plain, target: self, action: "performSegue")
        skipButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Lato-Bold", size: 15)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = skipButton
=======
        // Styling
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = buttonCornerRadius
        nextButton.enabled = false
        navigationItem.hidesBackButton = true
>>>>>>> origin/master
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
    
    @IBAction func didPressSkipButton(sender: UIButton) {
        performSegueWithIdentifier("segueToFollowFriends", sender: nil)
    }
    
}
