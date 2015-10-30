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
    var searchTerm = ""
    var searchLocation = ""
    
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
    
    
    // Event Cards -------------------------------------

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
            if self.searchTermField.text != "" {
                destinationViewController.searchTerm = self.searchTermField.text! // Assumes search is never empty
            }
        }
    }
    
    @IBAction func unwindFromSearch(segue: UIStoryboardSegue) {
        print(segue.destinationViewController)
        let fromViewController = segue.sourceViewController as! SearchViewController
        if fromViewController.searchTermField.text! != "" {
            print("Search Term Field contains: \(fromViewController.searchTermField.text!)")
            isSearchEnabled = true
            self.searchView.hidden = false
            self.searchTermField.text = fromViewController.searchTermField.text!
            searchTerm = fromViewController.searchTermField.text!
            searchLocation = fromViewController.searchLocationField.text!
        } else {
            print("Search Term Field is empty.")
            isSearchEnabled = false
            self.searchView.hidden = true
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
        print("Animating transition to Search...")
        let containerView = transitionContext.containerView()!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        let animationTime = 0.3
        
        if (isPresenting) {
            if toViewController.isKindOfClass(SearchViewController) { // Animate TO SearchViewController
                containerView.addSubview(toViewController.view)
                
                if self.isSearchEnabled {
                    print("Building `tempTextField`...")
                    let window = UIApplication.sharedApplication().keyWindow
                    let tempSearchTermField = UITextField(frame: CGRectMake(52, 28, 271, 28))
                    let tempSearchLocationField = UITextField(frame: tempSearchTermField.frame) // Create them in the same place
                    
                    tempSearchTermField.layer.cornerRadius = buttonCornerRadius
                    tempSearchTermField.leftView = UIImageView(image: UIImage(named: "icon_search_13x13"))
                    tempSearchTermField.leftView?.contentMode = UIViewContentMode.Center
                    tempSearchTermField.leftViewMode = UITextFieldViewMode.Always
                    tempSearchTermField.attributedPlaceholder = NSAttributedString(string: "Search",
                        attributes:[NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!, NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
                    tempSearchTermField.attributedText = NSAttributedString(string: self.searchTerm, attributes: [NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
                    tempSearchTermField.leftView?.frame.size.width = 28
                    tempSearchTermField.backgroundColor = UIColorFromRGB("389E8E")
                    
                    tempSearchLocationField.layer.cornerRadius = buttonCornerRadius
                    tempSearchLocationField.leftView = UIImageView(image: UIImage(named: "icon_location_13x13"))
                    tempSearchLocationField.leftView?.contentMode = UIViewContentMode.Center
                    tempSearchLocationField.leftViewMode = UITextFieldViewMode.Always
                    tempSearchLocationField.attributedPlaceholder = NSAttributedString(string: "Location",
                        attributes:[NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!, NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
                    tempSearchLocationField.attributedText = NSAttributedString(string: self.searchLocation, attributes: [NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
                    tempSearchLocationField.leftView?.frame.size.width = 28
                    tempSearchLocationField.backgroundColor = UIColorFromRGB("389E8E")
                    
                    window!.addSubview(tempSearchLocationField)
                    window!.addSubview(tempSearchTermField)
                    
                    let toVC = toViewController as! SearchViewController
                    toVC.searchTermField.alpha = 0
                    toVC.searchLocationField.alpha = 0
                    toVC.view.backgroundColor = UIColorFromRGB(colorBrandGreenCode, alpha: 0)
                    
                    transitionContext.completeTransition(true)
                    
                    UIView.animateWithDuration(animationTime, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                        print("Animating `tempTextField`...")
                        tempSearchTermField.frame.origin = CGPoint(x: 16, y: 64)
                        tempSearchTermField.frame.size.width = 343
                        tempSearchLocationField.frame.origin = CGPoint(x: 16, y: 100)
                        tempSearchLocationField.frame.size.width = 343
                        }) { (finished: Bool) -> Void in
                            tempSearchTermField.removeFromSuperview()
                            tempSearchLocationField.removeFromSuperview()
                            toVC.searchTermField.alpha = 1
                            toVC.searchLocationField.alpha = 1
                            toVC.view.backgroundColor = UIColorFromRGB(colorBrandGreenCode, alpha: 1)
                    }
                } else {
                    toViewController.view.alpha = 0
                    UIView.animateWithDuration(animationTime, animations: { () -> Void in
                        toViewController.view.alpha = 1
                        }) { (finished: Bool) -> Void in
                            transitionContext.completeTransition(true)
                    }
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
                // DO SOMETHING!!!
            }
        } else {
            if fromViewController.isKindOfClass(SearchViewController) { // Animate FROM SearchViewController
                let fromVC = fromViewController as! SearchViewController
                fromVC.searchTermField.alpha = 0
                fromVC.searchLocationField.alpha = 0
                UIView.animateWithDuration(animationTime, animations: { () -> Void in
                    fromViewController.view.alpha = 0
                    }) { (finished: Bool) -> Void in
                        transitionContext.completeTransition(true)
                        fromViewController.view.removeFromSuperview()
                }
                if self.isSearchEnabled {
                    print("Building `tempTextField`...")
                    let window = UIApplication.sharedApplication().keyWindow
                    let tempSearchTermField = UITextField(frame: CGRectMake(16, 64, 343, 28))
                    let tempSearchLocationField = UITextField(frame: CGRectMake(16, 100, 343, 28))
                    
                    tempSearchTermField.layer.cornerRadius = buttonCornerRadius
                    tempSearchTermField.leftView = UIImageView(image: UIImage(named: "icon_search_13x13"))
                    tempSearchTermField.leftView?.contentMode = UIViewContentMode.Center
                    tempSearchTermField.leftViewMode = UITextFieldViewMode.Always
                    tempSearchTermField.attributedPlaceholder = NSAttributedString(string: "Search",
                        attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
                    tempSearchTermField.attributedText = NSAttributedString(string: self.searchTermField.text!, attributes: [NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
                    tempSearchTermField.leftView?.frame.size.width = 28
                    tempSearchTermField.backgroundColor = UIColorFromRGB("389E8E")
                    
                    tempSearchLocationField.layer.cornerRadius = buttonCornerRadius
                    tempSearchLocationField.leftView = UIImageView(image: UIImage(named: "icon_location_13x13"))
                    tempSearchLocationField.leftView?.contentMode = UIViewContentMode.Center
                    tempSearchLocationField.leftViewMode = UITextFieldViewMode.Always
                    tempSearchLocationField.attributedPlaceholder = NSAttributedString(string: "Location",
                        attributes:[NSForegroundColorAttributeName: UIColorFromRGB("FFFFFF", alpha: 0.5)])
                    tempSearchLocationField.attributedText = NSAttributedString(string: "", attributes: [NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!, NSForegroundColorAttributeName:UIColor.whiteColor()])
                    tempSearchLocationField.leftView?.frame.size.width = 28
                    tempSearchLocationField.backgroundColor = UIColorFromRGB("389E8E")
                    
                    window!.addSubview(tempSearchLocationField)
                    window!.addSubview(tempSearchTermField)
                    
                    UIView.animateWithDuration(animationTime, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                        print("Animating `tempTextField`...")
                        tempSearchTermField.frame.origin = CGPoint(x: 52, y: 28)
                        tempSearchTermField.frame.size.width = 271
                        tempSearchLocationField.frame.origin = CGPoint(x: 52, y: 28)
                        tempSearchLocationField.frame.size.width = 271
                        }) { (finished: Bool) -> Void in
                            tempSearchTermField.removeFromSuperview()
                            tempSearchLocationField.removeFromSuperview()
                    }
                }
            }
        }
    }


}
