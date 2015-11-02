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
    var nextIndex = 0
    var events: [PFObject] = []
    var eventViewControllers: [UIViewController]! = []
    var lastContentOffset: CGFloat = 0
    var viewInitialXPosition: CGFloat = 0
    //var toVC: EventViewController!
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
                    for (index, object) in objects!.enumerate() {
                        print("\(index): \(object.objectId!)")
                        self.events.append(object)
                        
                        let viewController = self.viewControllerAtIndex(index)
                        self.eventViewControllers.append(viewController)
                    }
                    
                    self.setViewControllers([self.eventViewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
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
        event.index = index
        
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
        // Don't return a view controller out of bounds
        if index >= 0 && index < events.count - 1 {
            return self.eventViewControllers[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if index > 0 && index <= events.count - 1 {
            return self.eventViewControllers[index - 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        self.nextIndex = (pendingViewControllers[0] as! EventViewController).index
        print("nextIndex: \(nextIndex)")
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.index = self.nextIndex
    }
    
    
    // Parallax Animation ------------------------------
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //self.lastContentOffset = scrollView.contentOffset.x;
        self.viewInitialXPosition = scrollView.contentOffset.x;
    }
    
    // Parallax scroll the header from the next/previous EventViewController
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if eventViewControllers.count > 0 { // Check if there are view controllers to animate, or it'll crash
            let currentHeader = (eventViewControllers[index] as! EventViewController).eventBannerImage
            let nextHeader = (eventViewControllers[nextIndex] as! EventViewController).eventBannerImage
            let partialPage = scrollView.contentOffset.x / scrollView.frame.size.width;
            let exactPage = CGFloat(floor(partialPage))
            let percentage = partialPage - exactPage
            if self.viewInitialXPosition < scrollView.contentOffset.x { // Pan left
                currentHeader.center.x = (375/2) * percentage
                nextHeader.center.x = (375/2) * percentage
            } else { // Pan right
                currentHeader.center.x = 375 - ((375/2) * percentage)
                nextHeader.center.x = 375 - ((375/2) * percentage)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if eventViewControllers.count > 0 {
            (eventViewControllers[index] as! EventViewController).eventBannerImage.center.x = self.view.bounds.width/2
        }
    }

}
