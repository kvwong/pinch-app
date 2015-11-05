//
//  SearchFiltersTableViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class SearchFiltersTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var eventLengthDragger: UIView!
    @IBOutlet weak var eventDistanceDragger: UIView!
    
    var lengthPanGestureRecognizer: UIPanGestureRecognizer!
    var distancePanGestureRecognizer: UIPanGestureRecognizer!
    
    var draggerPosition: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lengthPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "draggerPan:")
        lengthPanGestureRecognizer.delegate = self
        eventLengthDragger.addGestureRecognizer(lengthPanGestureRecognizer)
        
        distancePanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "draggerPan:")
        distancePanGestureRecognizer.delegate = self
        eventDistanceDragger.addGestureRecognizer(distancePanGestureRecognizer)
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
    
    @IBAction func didPressCancelButton(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func didPressApplyButton(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func draggerPan(sender: UIPanGestureRecognizer) {
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        let translation = sender.translationInView(view)
        
        if sender.state == .Began {
            print("Dragger pan began.")
            if let view = sender.view {
                draggerPosition = view.center.x
                UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                    view.transform = CGAffineTransformMakeScale(0.8, 0.8)
                    }, completion: nil)
            }
        } else if sender.state == .Changed {
            print("Dragger is panning. draggerPosition: \(draggerPosition), translation.x: \(translation.x)")
            if let view = sender.view {
                if draggerPosition + translation.x >= 25 && draggerPosition + translation.x <= 350 {
                    view.center = CGPoint(x: draggerPosition + translation.x,
                        y: view.center.y)
                }
            }
        } else if sender.state == .Ended {
            print("Dragger pan ended.")
            if let view = sender.view {
                if view == eventLengthDragger {
                    print("eventLengthDragger")
                    let xPosition = view.center.x
                    let segmentWidth: CGFloat = (350 - 25)/5
                    let point1: CGFloat = 25
                    let point1half: CGFloat =   point1 + segmentWidth/2
                    let point2: CGFloat =       point1 + segmentWidth
                    let point2half: CGFloat =   point1 + segmentWidth + segmentWidth/2
                    let point3: CGFloat =       point1 + (segmentWidth * 2)
                    let point3half: CGFloat =   point1 + (segmentWidth * 2) + segmentWidth/2
                    let point4: CGFloat =       point1 + (segmentWidth * 3)
                    let point4half: CGFloat =   point1 + (segmentWidth * 3) + segmentWidth/2
                    let point5: CGFloat =       point1 + (segmentWidth * 4)
                    let point5half: CGFloat =   point1 + (segmentWidth * 4) + segmentWidth/2
                    let point6: CGFloat = 350
                    if xPosition <= point1half {
                        animateDraggerToPosition(view, position: point1)
                    } else if xPosition > point1half && xPosition <= point2 {
                        animateDraggerToPosition(view, position: point2)
                    } else if xPosition > point2 && xPosition <= point2half {
                        animateDraggerToPosition(view, position: point2)
                    } else if xPosition > point2half && xPosition <= point3 {
                        animateDraggerToPosition(view, position: point3)
                    } else if xPosition > point3 && xPosition <= point3half {
                        animateDraggerToPosition(view, position: point3)
                    } else if xPosition > point3half && xPosition <= point4 {
                        animateDraggerToPosition(view, position: point4)
                    } else if xPosition > point4 && xPosition <= point4half {
                        animateDraggerToPosition(view, position: point4)
                    } else if xPosition > point4half && xPosition <= point5 {
                        animateDraggerToPosition(view, position: point5)
                    } else if xPosition > point5 && xPosition <= point5half {
                        animateDraggerToPosition(view, position: point5)
                    } else if xPosition > point5half && xPosition <= point6 {
                        animateDraggerToPosition(view, position: point6)
                    }
                } else if view == eventDistanceDragger {
                    print("eventDistanceDragger")
                }
                
                UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                    view.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: nil)
            }
        }
    }
    
    func animateDraggerToPosition(view: UIView, position: CGFloat) {
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            view.center.x = position
            }, completion: nil)
    }
    
}
