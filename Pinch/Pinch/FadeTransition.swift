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
        
        let eventDetailViewController = toViewController as! EventViewController
        let homeViewController = fromViewController as! HomeViewController
        
        //let destinationFrame = eventDetailViewController.view

        eventDetailViewController.eventSummaryView = homeViewController.cardView
        print("WOWOWOWOWO")
        
        toViewController.view.alpha = 0
        toViewController.view.transform = CGAffineTransformMakeScale(0.746667, 0.746667)
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.alpha = 1
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1)
            toViewController.view.frame.origin.y = 0

            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            fromViewController.view.transform = CGAffineTransformMakeScale(0.746667, 0.746667)
            fromViewController.view.frame.origin.y = 104
            }) { (finished: Bool) -> Void in
                self.finish()
        }
    }
}