//
//  HomeViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    var eventCardTransition: EventCardTransition!
    var cardView: UIView!
    var status: Bool!
    var initialY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status = false
        
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

    @IBAction func panEventCard(sender: AnyObject) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            initialY = eventView.frame.origin.y
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            eventView.frame.origin.y = initialY + translation.y
            
            print(translation.y)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nav = segue.destinationViewController as! UINavigationController
        let eventDetailViewController = nav.topViewController as! EventViewController
    
        eventDetailViewController.eventSummary = cardView
        eventCardTransition = EventCardTransition()
        eventDetailViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        eventDetailViewController.transitioningDelegate = eventCardTransition
        
        eventCardTransition.isInteractive = true
    }
    

}
