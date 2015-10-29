//
//  HomeViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import UIImageEffects

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    // Outlets and Vars --------------------------------
    
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventContentView: UIView!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTermField: UITextField!
    @IBOutlet weak var summaryBannerImage: UIImageView!
    
    var eventCardTransition: EventCardTransition!
    var cardView: UIView!
    var status: Bool!
    var initialY: CGFloat!
    var fadeTransition: FadeTransition!
    
    var isPresenting: Bool = true
    var isSearchEnabled: Bool = false
    
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    
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
        searchTermField.layer.cornerRadius = buttonCornerRadius
        searchTermField.leftView = UIImageView(image: UIImage(named: "icon_search_13x13"))
        searchTermField.leftView?.frame = CGRectMake(0, 0, 28, 28)
        searchTermField.leftView?.contentMode = UIViewContentMode.Center
        searchTermField.leftViewMode = UITextFieldViewMode.Always
        searchTermField.attributedPlaceholder = NSAttributedString(string: "Search",
            attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
        
        tagButton1.layer.cornerRadius = 3
        tagButton2.layer.cornerRadius = 3
        
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
    

    @IBAction func panEventCard(sender: AnyObject) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            initialY = eventView.frame.origin.y
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            eventView.frame.origin.y = initialY + translation.y
            
            let multipleX = (abs(translation.y)/75) + 1.0
            let multipleY = (abs(translation.y)/75) + 1.0
            
            if velocity.y < 0 {
                eventView.transform = CGAffineTransformMakeScale(multipleX, multipleY)
            }
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if eventView.frame.origin.y > 10 {
                eventView.frame.origin.y = initialY
                
            } else if eventView.frame.origin.y < 10 {
                eventView.frame.origin.y = 0.0
                }
            }
            
    }
    // Custom Transitions ------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventDetailSegue" {
            
            let nav = segue.destinationViewController as! UINavigationController
            let eventDetailViewController = nav.topViewController as! EventViewController
            
            fadeTransition = FadeTransition()
            eventDetailViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
            eventDetailViewController.transitioningDelegate = fadeTransition
            fadeTransition.duration = 2.0
            
            eventDetailViewController.eventSummary = cardView
            eventDetailViewController.summaryBannerImage = summaryBannerImage.image
        
        } else if segue.identifier == "segueToSearch" {
            let destinationViewController = segue.destinationViewController as! SearchViewController
            destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationViewController.transitioningDelegate = self
            if searchTermField.text != "" {
                destinationViewController.searchTerm = searchTermField.text! // Assumes search is never empty
            }
        }
    }
    
    @IBAction func unwindFromSearch(segue: UIStoryboardSegue) {
        print(segue.destinationViewController)
        let fromViewController = segue.sourceViewController as! SearchViewController
        if fromViewController.searchTermField.text! != "" {
            print("Search Term Field contains: \(fromViewController.searchTermField.text!)")
            isSearchEnabled = true
            searchView.hidden = false
            searchTermField.text = fromViewController.searchTermField.text!
        } else {
            print("Search Term Field is empty.")
            isSearchEnabled = false
            searchView.hidden = true
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
        print("Animating transition...")
        let containerView = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        let animationTime = 0.3
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                toViewController.view.alpha = 1
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
            if self.isSearchEnabled {
                UIView.animateWithDuration(animationTime, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                    self.searchTermField.frame.origin = CGPoint(x: 16, y: 44)
                    self.searchTermField.frame.size.width = 343
                    }, completion: nil)
            }
            /*
            let image = UIGraphicsGetImageFromCurrentImageContext()
            let blurredImage = image.applyBlurWithRadius(
            CGFloat(5),
            tintColor: nil,
            saturationDeltaFactor: 1.0,
            maskImage: nil
            )
            */
        } else {
            containerView.addSubview(searchTermField) // Not working yet
            UIView.animateWithDuration(animationTime, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
            if self.isSearchEnabled {
                UIView.animateWithDuration(animationTime, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                    self.searchTermField.frame.origin = CGPoint(x: 52, y: 8)
                    self.searchTermField.frame.size.width = 271
                    }, completion: nil)
            }
        }
    }


}
