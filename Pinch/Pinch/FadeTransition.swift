//
//  FadeTransition.swift
//  transitionDemo
//
//  Created by Timothy Lee on 11/4/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class FadeTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        print("2")
        //let eventDetailViewController = toViewController as! EventViewController
        let nav = toViewController as! UINavigationController
        let eventDetailViewController = nav.viewControllers.first as! EventViewController   
        let homeViewController = fromViewController as! HomeViewController
        
        //let destinationFrame = eventDetailViewController.view

        eventDetailViewController.eventSummaryView = homeViewController.cardView
        print("WOWOWOWOWO")
        
        eventDetailViewController.view.alpha = 0
        eventDetailViewController.view.transform = CGAffineTransformMakeScale(0.746667, 0.746667)
        UIView.animateWithDuration(duration, animations: {
            eventDetailViewController.view.alpha = 1
            eventDetailViewController.view.transform = CGAffineTransformMakeScale(1, 1)
            eventDetailViewController.view.frame.origin.y = 0

            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.navigationController?.setNavigationBarHidden(true, animated: false)
            fromViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            fromViewController.view.alpha = 0
            fromViewController.view.transform = CGAffineTransformMakeScale(0.746667, 0.746667)
            fromViewController.view.frame.origin.y = 104
            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
}