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
//        
//        tagListView.collectionView.dataSource = self
//        tagListView.collectionView.delegate = self

        scrollView.contentSize = CGSizeMake(340, 600)
        
        // Next button styles
        nextButton.layer.cornerRadius = buttonCornerRadius
        
        // Bottom gradient styles
        let topColor = UIColorFromRGB("F5F5F5", alpha: 0)
        let bottomColor = UIColorFromRGB("F5F5F5", alpha: 1)
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0 , 1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.frame = gradientLayerView.bounds
        gradientLayerView.layer.insertSublayer(gradientLayer, atIndex: 0)
        
        // Tag cloud styles
        tagListView.canSeletedTags = true
        tagListView.tagCornerRadius = 10
        tagListView.collectionView.scrollEnabled = false
        tagListView.collectionView.backgroundColor = colorBackgroundLight
        tagListView.tagColor = UIColorFromRGB("47C6B2", alpha: 1)
        //tagListView.tintColor = UIColorFromRGB("47C6B2", alpha: 1)
        //tagListView.backgroundColor = UIColorFromRGB("47C6B2", alpha: 1)
        
        
        for cause in Cause.allValues {
            tagListView.tags.addObject(cause.rawValue) // Populates the tag cloud from the Cause enum
            //tagListView.collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: cause.hashValue, inSection: 0))?.layer.backgroundColor = UIColor.redColor().CGColor
        }
        

        
//        var cell = tagListView.collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        
        
        //tagListView.collectionView.cellForItemAtIndexPath(NSIndexPath(index: 0))?.layer.backgroundColor = UIColor.redColor().CGColor
        
        tagListView.setCompletionBlockWithSeleted { (index) -> Void in
            print("Index: \(index)")
        }
    }
    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //return tagListView.tags.count
//        return 100
//    }
//    
//   
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath
//        indexPath: NSIndexPath) -> UICollectionViewCell {
//            
//            let cell = tagListView.collectionView.dequeueReusableCellWithReuseIdentifier("cell",
//                forIndexPath: indexPath)
//            
//           return cell
//            
//    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath
//        indexPath: NSIndexPath) {
//            
//            var cell = collectionView.cellForItemAtIndexPath(indexPath)
//            
//            
//            cell!.backgroundView!.backgroundColor = UIColor.redColor()
//            cell!.selectedBackgroundView!.backgroundColor = UIColor.blueColor()
//            
//    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.hidesBackButton = true
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
