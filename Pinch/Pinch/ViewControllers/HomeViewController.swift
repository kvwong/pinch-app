//
//  HomeViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    var eventCardTransition: EventCardTransition!
    var cardView: UIView!
    var status: Bool!
    
    var isPresenting: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status = false
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
    
    @IBAction func didPressSearchButton(sender: UIButton) {
        performSegueWithIdentifier("segueToSearch", sender: nil)
    }

    @IBAction func onTap(sender: AnyObject) {
        cardView = sender.view as UIView!
        performSegueWithIdentifier("eventDetailSegue", sender: nil)
    }

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
