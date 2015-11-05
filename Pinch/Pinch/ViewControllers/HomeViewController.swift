//
//  HomeViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import UIImageEffects
import Parse


class HomeViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UIGestureRecognizerDelegate {
    
    // Outlets and Vars --------------------------------
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var eventContainerView: UIView!
    @IBOutlet weak var bottomNavView: UIView!
    @IBOutlet weak var eventCloseButton: UIButton!


    // Search
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTermField: UITextField!
    
    var isSearchEnabled: Bool = false
    var searchTerm = ""
    var searchLocation = ""
    
    // Events
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var eventContentView: UIView!
    @IBOutlet weak var summaryBannerImage: UIImageView!
    @IBOutlet weak var scheduledDate: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var npoLabel: UILabel!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var friend1: UIImageView!
    @IBOutlet weak var friend2: UIImageView!
    @IBOutlet weak var friend3: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    var pageViewController: UIPageViewController!
    
    var eventCardTransition: EventCardTransition!
    var interactiveTransition: UIPercentDrivenInteractiveTransition!
    var cardView: UIView!
    var status: Bool!
    var initialY: CGFloat!
    var initialX: CGFloat!
    var fadeTransition: FadeTransition!
    
    var isPresenting: Bool = true
    var wasTapped: Bool = true
    
    var events: [PFObject] = []
    
    // Overrides ---------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status = false
        
        eventView.alpha = 0
        containerScrollView.alpha = 1
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        pageViewController = storyboard.instantiateViewControllerWithIdentifier("EventPageViewController") as! EventPageViewController
        
        self.pageViewController.view.layer.cornerRadius = 4

        //containerScrollView.delegate = self
        
        pageViewController.view.frame = eventContainerView.bounds
        //pageViewController.view.transform = CGAffineTransformMakeScale(1.0,1.0)
        pageViewController.view.transform = CGAffineTransformMakeScale(0.85,0.85)
        addChildViewController(pageViewController)
        pageViewController.view.userInteractionEnabled = false
        eventContainerView.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    
        
        containerScrollView.contentSize.width = 2000
        
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
        searchTermField.delegate = self
        
        tagButton1.layer.cornerRadius = 3
        tagButton2.layer.cornerRadius = 3
        
        // Display search UIView if active
        if isSearchEnabled {
            searchView.hidden = false
        } else {
            searchView.hidden = true
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
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        //Temp Text
        descriptionLabel.text = "This is the text from the Home View Controller"
        
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
    
    /*
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return
    }
    */
    
    
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        performSegueWithIdentifier("segueToSearch", sender: nil)
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("Clearing textfield...")
        searchTermField.resignFirstResponder()
        isSearchEnabled = false
        UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.searchView.frame.origin.y = 0 - self.searchView.frame.height
            }, completion: nil)
        return false
    }
    
    
    // Event Cards -------------------------------------
    
    @IBAction func onTap(sender: AnyObject) {
        print("tapped card")
        cardView = sender.view as UIView!
        performSegueWithIdentifier("eventDetailSegue", sender: nil)
        fadeTransition.finish()
        eventView.frame.origin.y = 104
        //eventView.transform = CGAffineTransformMakeScale(1.0, 1.0)
    }
    
    @IBAction func backButton(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            print("event back button")
            self.pageViewController.view.userInteractionEnabled = true
            self.eventContainerView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            self.containerScrollView.frame.origin.y = 40
            self.bottomNavView.frame.origin.y = 592
            self.pageViewController.view.userInteractionEnabled = false
            self.pageViewController.view.layer.cornerRadius = 4

        })
    }
    
    @IBAction func onTapContainer(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
         
            self.pageViewController.view.userInteractionEnabled = true
            self.eventContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.pageViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.eventContainerView.frame.origin.y = 0
            self.containerScrollView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            self.containerScrollView.frame.origin.y = 0
            self.bottomNavView.frame.origin.y = 668
            self.pageViewController.view.layer.cornerRadius = 4

        })
    }
    
    @IBAction func panContainer(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            initialY = eventContainerView.frame.origin.y
            initialX = eventContainerView.frame.origin.x
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            eventContainerView.frame.origin.y = initialY + translation.y
            //eventContainerView.frame.origin.x = initialX + translation.x
            
            /*if eventContainerView.frame.origin.y < 29 && eventContainerView.frame.origin.y > 0 {
                eventContainerView.transform = CGAffineTransformMakeScale(1.0+(abs(translation.y)/29),1.0+(abs(translation.y)/29))
                print(abs(translation.y))
            }*/
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity.y < 0 && eventContainerView.frame.origin.y < initialY {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    
                    self.pageViewController.view.userInteractionEnabled = true
                    self.eventContainerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.pageViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.eventContainerView.frame.origin.y = 0
                    self.containerScrollView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    self.containerScrollView.frame.origin.y = 0
                    self.bottomNavView.frame.origin.y = 668
                    self.pageViewController.view.layer.cornerRadius = 4

                    
                })
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.eventContainerView.frame.origin.y = self.initialY
                    self.eventContainerView.frame.origin.x = self.initialX
                    //eventContainerView.transform = CGAffineTransformIdentity
                    })
            }
            
            if velocity.y > 0 && eventContainerView.frame.origin.y == 0 {
                //eventContainerView.frame.origin.y = 0
            }
        }
    }
    
    // Gesture Interaction for Card
    @IBAction func panEventCard(sender: AnyObject) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            initialY = eventView.frame.origin.y
            performSegueWithIdentifier("eventDetailSegue", sender: nil)
            print("gesture began")
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            //print("gesture changing")
            //let distance = initialY-(abs(translation.y))
            //print(translation.y)
            //print(distance)
            //print(velocity.y)
            //print(distance/104)
            //interactiveTransition.updateInteractiveTransition((distance/104))
            
            eventView.frame.origin.y = initialY + translation.y
            //eventView.transform = CGAffineTransformMakeScale(1.0+abs(translation.y/208), 1.0+abs(translation.y/208))
            
            
            if eventView.frame.origin.y < 104 && eventView.frame.origin.y > 0 {
                fadeTransition.percentComplete = abs(translation.y)/104
            } else {
                // do nothing
            }
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            eventView.frame.origin.y = 104
            eventView.transform = CGAffineTransformMakeScale(1.0, 1.0)
            if velocity.y < 0.0 {
                fadeTransition.finish()
            } else {
                fadeTransition.cancel()
                dismissViewControllerAnimated(false, completion: nil)
            }
        }
    }
    
    /*
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    interactiveTransition = UIPercentDrivenInteractiveTransition()
    //Setting the completion speed gets rid of a weird bounce effect bug when transitions complete
    interactiveTransition.completionSpeed = 0.99
    return interactiveTransition
    }*/
    
    
    // Custom Transitions ------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventDetailSegue" {
            
            fadeTransition = FadeTransition()
            fadeTransition.isInteractive = true
            print("1")
            let nav = segue.destinationViewController as! UINavigationController
            
            let eventDetailViewController = nav.topViewController as! EventViewController

            eventDetailViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
            nav.transitioningDelegate = fadeTransition
            fadeTransition.duration = 0.5
            
            // Pass data to Destination Event View Controller
            eventDetailViewController.eventSummary = cardView
            eventDetailViewController.summaryBannerImage = summaryBannerImage.image
            eventDetailViewController.titleLabel = titleLabel.text
            eventDetailViewController.scheduleDate = scheduledDate.text
            eventDetailViewController.addressLabel = addressLabel.text
            eventDetailViewController.npoLabel = npoLabel.text
            eventDetailViewController.friend1Image = friend1.image
            eventDetailViewController.friend2Image = friend2.image
            eventDetailViewController.friend3Image = friend3.image
            eventDetailViewController.descriptionLabel = descriptionLabel.text
            //eventDetailViewController.eventObjectID = events[0].objectId
            eventDetailViewController.event = events[0]
            

            //let eventDetailViewController = page.topViewController as! EventViewController
            //let pageViewController = nav.topViewController as! EventPageViewController
            //let eventDetailViewController = segue.destinationViewController as! EventViewController
            
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
            self.searchView.frame.origin.y = 20
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
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
                eventCloseButton.alpha = 0
                containerView.addSubview(toViewController.view)
                if self.isSearchEnabled {
                    print("Search is enabled.")
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
                    toVC.backgroundView.alpha = 0
                    self.searchTermField.alpha = 0
                    /*
                    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
                    visualEffectView.frame = self.view.bounds
                    containerView.insertSubview(visualEffectView, atIndex: 0)
                    */
                    transitionContext.completeTransition(true)
                    
                    UIView.animateWithDuration(animationTime, animations: { () -> Void in
                        toVC.backgroundView.alpha = 1
                        
                    })
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
                            self.eventCloseButton.alpha = 0
                    }
                } else {
                    toViewController.view.alpha = 0
                    print("Search is not enabled.")
                    let toVC = toViewController as! SearchViewController
                    toVC.searchTermField.text = ""
                    UIView.animateWithDuration(animationTime, animations: { () -> Void in
                        toViewController.view.alpha = 1
                        }) { (finished: Bool) -> Void in
                            transitionContext.completeTransition(true)
                    }
                }
            } else if toViewController.isKindOfClass(EventViewController) { // Animate TO EventViewController
                // DO SOMETHING!!!
                print("Animate TO Card")
                containerView.addSubview(toViewController.view)
                UIView.animateWithDuration(animationTime, animations: { () -> Void in
                    toViewController.view.alpha = 1
                    }) { (finished: Bool) -> Void in
                        transitionContext.completeTransition(true)
                }
            }
        } else {
            eventCloseButton.alpha = 1
            if fromViewController.isKindOfClass(SearchViewController) { // Animate FROM SearchViewController
                let fromVC = fromViewController as! SearchViewController
                fromVC.searchTermField.alpha = 0
                fromVC.searchLocationField.alpha = 0
                UIView.animateWithDuration(animationTime, animations: { () -> Void in
                    fromViewController.view.alpha = 0
                    }) { (finished: Bool) -> Void in
                        transitionContext.completeTransition(true)
                        fromViewController.view.removeFromSuperview()
                        containerView.removeFromSuperview()
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
                            self.searchTermField.alpha = 1
                    }
                }
            } else if fromViewController.isKindOfClass(EventViewController) { // Animate FROM EventViewController
                // DO SOMETHING!!!
                print("Animate FROM Card")
                
            }
        }
    }
    
    
}
