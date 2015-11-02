//
//  EventPageViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/31/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class EventPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {

    var index = 0
    var events: [PFObject] = []
    var lastContentOffset: CGFloat = 0
    var toVC: EventViewController!
    var direction = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        // Look for a UIScrollView inside the PageViewController
        for view in self.view.subviews {
            if view.isKindOfClass(UIScrollView) {
                (view as! UIScrollView).delegate = self
            }
        }
        
        // Download events from Parse
        let query = PFQuery(className:"Event")
        query.includeKey("organization") // Include Organization class
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) events.")
                // Do something with the found objects
                if let objects = objects as? [PFObject]? {
                    let eventViewControllers: NSMutableArray = []
                    for (index, object) in objects!.enumerate() {
                        print("\(index): \(object.objectId!)")
                        self.events.append(object)
                        
                        let viewController = self.viewControllerAtIndex(index)
                        eventViewControllers.addObject(viewController)
                    }
                    
                    self.setViewControllers(eventViewControllers as! [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Build EventView Controllers for H-Scroll --------
    
    func viewControllerAtIndex(index: Int) -> EventViewController! {
        
        let event = self.storyboard!.instantiateViewControllerWithIdentifier("EventViewController") as! EventViewController
        
        // Populate data from Parse
        
        // Header image
        let imageURL = self.events[index]["imageURL"] as! String
        let imageData = NSData(contentsOfURL: NSURL(string: imageURL)!)
        event.summaryBannerImage = UIImage(data: imageData!)
        
        // Header text
        event.titleLabel = self.events[index]["name"] as! String
        let street = self.events[index]["addressStreet"] as! String
        let city = self.events[index]["addressCity"] as! String
        let state = self.events[index]["addressState"] as! String
        let zip = self.events[index]["addressZIP"] as! String
        event.addressLabel = "\(street), \(city), \(state) \(zip)"
        
        // Non-profit name
        event.npoLabel = self.events[index]["organization"]["name"] as! String
        
        // Event description
        event.descriptionLabel = self.events[index]["description"] as! String
        
        print("Event \(event) created at index \(index)")
        return event
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        self.direction = "left"
        // Don't return a view controller out of bounds
        if index >= 0 && index < events.count - 1 {
            self.toVC = self.viewControllerAtIndex(++index)
            return self.toVC
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        self.direction = "right"
        if index >= 0 && index < events.count - 1 {
            self.toVC = self.viewControllerAtIndex(--index)
            return self.toVC
        } else {
            return nil
        }
    }
    
    
    // Parallax Animation ------------------------------
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.x;
    }
    
    // Parallax scroll the header from the next/previous EventViewController
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if toVC != nil {
            let headerImage = (toVC as! EventViewController).eventBannerImage
            let partialPage = scrollView.contentOffset.x / scrollView.frame.size.width;
            let exactPage = CGFloat(floor(partialPage))
            let percentage = partialPage - exactPage
            print("partialPage: \(partialPage), exactPage: \(exactPage), percentage: \(percentage)")
            /*if self.lastContentOffset > scrollView.contentOffset.x { // Scrolling right!
                //print("Scrolling the view right!")
            } else if self.lastContentOffset < scrollView.contentOffset.x { // Scrolling left!
                //print("Scrolling the view left!")
            }*/
            if direction == "left" {
                headerImage.center = CGPoint(x: (375/2) * percentage, y: headerImage.center.y)
            } else if direction == "right" {
                headerImage.center = CGPoint(x: 375-(375/2) * percentage, y: headerImage.center.y)
            }
        }
        
        self.lastContentOffset = scrollView.contentOffset.x;
    }

}
