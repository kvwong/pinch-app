//
//  HomeViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    // Outlets and Vars --------------------------------
    
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventContentView: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchField: UITextField!
    
    var eventCardTransition: EventCardTransition!
    var cardView: UIView!
    var status: Bool!
    
    var isPresenting: Bool = true
    
    var isSearchEnabled: Bool = false
    
    
    // Overrides ---------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status = false
        
        // Event card styles
        eventView.layer.cornerRadius = buttonCornerRadius * 1.5
        eventContentView.layer.cornerRadius = eventView.layer.cornerRadius
        eventContentView.layer.masksToBounds = true
        eventView.layer.shadowOffset = CGSize(width: 0, height: 2)
        eventView.layer.shadowOpacity = 0.05
        eventView.layer.shadowRadius = 3
        
        // Search field styles
        searchField.layer.cornerRadius = buttonCornerRadius
        searchField.leftView = UIImageView(image: UIImage(named: "icon_search_13x13"))
        searchField.leftView?.frame = CGRectMake(0, 0, 28, 28)
        searchField.leftView?.contentMode = UIViewContentMode.Center
        searchField.leftViewMode = UITextFieldViewMode.Always
        searchField.attributedPlaceholder = NSAttributedString(string: "Search",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        
        // Display search UIView if active
        if isSearchEnabled {
            searchView.hidden = false
        } else {
            searchView.hidden = true
        }
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

    
    // Search ------------------------------------------
    
    @IBAction func didPressSearchButton(sender: UIButton) {
        performSegueWithIdentifier("segueToSearch", sender: nil)
    }
    
    @IBAction func didPressBackToSearchButton(sender: UIButton) {
        performSegueWithIdentifier("segueToSearch", sender: nil)
    }
    
    @IBAction func didPressFilterButton(sender: UIButton) {
        performSegueWithIdentifier("segueToFilters", sender: nil)
    }

    @IBAction func onTap(sender: AnyObject) {
        cardView = sender.view as UIView!
        performSegueWithIdentifier("eventDetailSegue", sender: nil)
    }
    

    // Custom Transitions ------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventDetailSegue" {
            let nav = segue.destinationViewController as! UINavigationController
            let eventDetailViewController = nav.topViewController as! EventViewController
            eventDetailViewController.eventSummary = cardView
        } else if segue.identifier == "segueToSearch" {
            let destinationVC = segue.destinationViewController as UIViewController
            destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationVC.transitioningDelegate = self
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        print("animating transition")
        let containerView = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                toViewController.view.alpha = 1
                /*var blurredImage = originalImage.applyBlurWithRadius(
                    CGFloat(radius),
                    tintColor: nil,
                    saturationDeltaFactor: 1.0,
                    maskImage: nil
                )*/
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }


}
