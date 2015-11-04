//
//  UserProfileViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import Parse

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    // Upcoming & Saved Event Table View
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewContent: UIView!
    @IBOutlet weak var housingCardView: UIImageView!
    @IBOutlet weak var youthCardView: UIImageView!
    @IBOutlet weak var medicineCardView: UIImageView!
    @IBOutlet weak var reliefCardView: UIView!
    @IBOutlet weak var artCardView: UIImageView!
    @IBOutlet weak var environmentCardView: UIView!
    @IBOutlet weak var internationalCardView: UIView!
    @IBOutlet weak var pastEventsLabel: UILabel!
    
    let scrollViewClosedY: CGFloat = 150
    let scrollViewOpenY: CGFloat = 208
    
    let currentUser = PFUser.currentUser()
    
    struct Card{
        var startOrigin: CGPoint
        var endOrigin: CGPoint
        var startRotation: CGFloat
        var endRotation: CGFloat
        //var view: UIImageView
    }
    /*
    let cards = [
        Card(startOrigin: CGPoint(x: 90, y: 30), endOrigin: CGPoint(x: 20, y: 60), startRotation: radian(-39), endRotation: 0, ) // blue
    ]*/
    
    //blue
    var card1 = Card(startOrigin: CGPoint(x: 90, y: 30), endOrigin: CGPoint(x: 20, y: 60), startRotation: radian(-39), endRotation: 0)
    //green
    var card2 = Card(startOrigin: CGPoint(x: 20, y: 60), endOrigin: CGPoint(x: 135, y: 60), startRotation: radian(-70), endRotation: 0)
    //red
    var card3 = Card(startOrigin: CGPoint(x: 204, y: 92), endOrigin: CGPoint(x: 250, y: 60), startRotation: radian(79), endRotation: 0)
    //yellow
    var card4 = Card(startOrigin: CGPoint(x: 158, y: 57), endOrigin: CGPoint(x: 365, y: 60), startRotation: radian(14), endRotation: 0)
    //purple
    var card5 = Card(startOrigin: CGPoint(x: 71, y: 92), endOrigin: CGPoint(x: 480, y: 60), startRotation: radian(-23), endRotation: 0)
    //dark green
    var card6 = Card(startOrigin: CGPoint(x: 279, y: 92), endOrigin: CGPoint(x: 595, y: 60), startRotation: radian(57), endRotation: 0)
    //dark purple
    var card7 = Card(startOrigin: CGPoint(x: 209, y: 34), endOrigin: CGPoint(x: 710, y: 60), startRotation: radian(18), endRotation: 0)
    
    var eventTabsView: UserProfileEventTabsTableViewCell!
    var eventTabsViewInitialY: CGFloat!
    
    // Overrides ---------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        eventsTableView.tableFooterView = UIView.init(frame: CGRectZero)

        scrollView.delegate = self
        scrollView.contentSize.width = scrollViewContent.frame.width + 32
        
        //scrollView.userInteractionEnabled = false
        //self.view.addGestureRecognizer(scrollView.panGestureRecognizer)
        
        //scrollView.panGestureRecognizer.delegate = self

        // Initialize cards
        print("Initalizing Cards")
        housingCardView.frame.origin = card1.startOrigin
        housingCardView.transform = CGAffineTransformMakeRotation(card1.startRotation)
        
        youthCardView.frame.origin = card2.startOrigin
        youthCardView.transform = CGAffineTransformMakeRotation(card2.startRotation)
        
        medicineCardView.frame.origin = card3.startOrigin
        medicineCardView.transform = CGAffineTransformMakeRotation(card3.startRotation)
        
        reliefCardView.frame.origin = card4.startOrigin
        reliefCardView.transform = CGAffineTransformMakeRotation(card4.startRotation)
        
        artCardView.frame.origin = card5.startOrigin
        artCardView.transform = CGAffineTransformMakeRotation(card5.startRotation)
        
        environmentCardView.frame.origin = card6.startOrigin
        environmentCardView.transform = CGAffineTransformMakeRotation(card6.startRotation)
        
        internationalCardView.frame.origin = card7.startOrigin
        internationalCardView.transform = CGAffineTransformMakeRotation(card7.startRotation)
        
        eventTabsView = eventsTableView.dequeueReusableCellWithIdentifier("UserProfileEventTabsTableViewCell") as! UserProfileEventTabsTableViewCell
        eventTabsViewInitialY = 404
        eventTabsView.frame.origin.y = eventTabsViewInitialY - eventsTableView.contentOffset.y
        view.addSubview(eventTabsView)
        
        // Styling
        pastEventsLabel.alpha = 0
        eventsTableView.showsVerticalScrollIndicator = false
        
        /*

eventView.layer.cornerRadius = buttonCornerRadius * 1.5
eventContentView.layer.cornerRadius = eventView.layer.cornerRadius
eventContentView.layer.masksToBounds = true
eventView.layer.shadowOffset = CGSize(width: 0, height: 2)
eventView.layer.shadowOpacity = 0.05
eventView.layer.shadowRadius = 3
*/

        // Download data from Parse
        if currentUser != nil {
            var name = currentUser!["firstName"] as! String
            //print("Hello, I'm \(name)")
            self.title = name
            pastEventsLabel.text = "\(name)'s Past Events"
        }

    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let panGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
        
        let location = panGestureRecognizer.locationInView(view)
        if location.y < scrollViewOpenY {
            return true
        }
        
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    

    // Button Actions ----------------------------------
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressNonProfits(sender: UIButton) {
        performSegueWithIdentifier("segueToFollowing", sender: "Non-Profits")
    }
    
    @IBAction func didPressFollowing(sender: UIButton) {
        performSegueWithIdentifier("segueToFollowing", sender: "Following")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? UserFollowingViewController {
            if sender as? String == "Non-Profits" {
                destination.title = "Non-Profits"
            } else {
                destination.title = "Following"
            }
        }
    }
    
    
    // Scroll View Overrides ---------------------------
    
    // Automatically snap eventsTableView
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let middlePoint = (scrollViewOpenY - scrollViewClosedY)/2
        if eventsTableView.contentOffset.y < -scrollViewClosedY && eventsTableView.contentOffset.y > -(scrollViewClosedY + middlePoint) {
            print("Returning eventsTableView to CLOSED POSITION")
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.eventsTableView.contentInset.top = self.scrollViewClosedY
                self.eventsTableView.contentOffset.y = -self.scrollViewClosedY
                self.pastEventsLabel.alpha = 0
                }, completion: nil)
        } else if eventsTableView.contentOffset.y < -(scrollViewClosedY + middlePoint) && eventsTableView.contentOffset.y > -scrollViewOpenY {
            print("Returning eventsTableView to OPEN POSITION")
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.eventsTableView.contentInset.top = self.scrollViewOpenY
                self.eventsTableView.contentOffset.y = -self.scrollViewOpenY
                self.pastEventsLabel.alpha = 1
                }, completion: nil)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var percentScroll: CGFloat!
        
        if eventsTableView.contentOffset.y > 340 {
            eventTabsView.frame.origin.y = 64
        } else {
            eventTabsView.frame.origin.y = eventTabsViewInitialY - eventsTableView.contentOffset.y
        }
        
        // Hide or reveal the nav bar
        if eventsTableView.contentOffset.y > 0 {
            print("eventsTableView.content.y offset is: \(eventsTableView.contentOffset.y)")
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
        }
        
        // Reposition contentInset if eventsTableView is scrolling off screen
        if eventsTableView.contentOffset.y > 0 {
            var inset: UIEdgeInsets = eventsTableView.contentInset
            let rect: CGRect = eventsTableView.convertRect(eventsTableView.rectForHeaderInSection(1), toView: eventsTableView.superview)
            if rect.origin.y <= 64 {
                inset.top = 64 + rect.height
            } else {
                inset.top = 0
            }
            eventsTableView.contentInset = inset
            
        } else {
            var inset: UIEdgeInsets = eventsTableView.contentInset
            inset.top = scrollViewOpenY
            eventsTableView.contentInset = inset
        }
        
        // Adjust cards and past events label based on scroll position
        if eventsTableView.contentOffset.y < -scrollViewClosedY && eventsTableView.contentOffset.y > -scrollViewOpenY {
            percentScroll = (-scrollView.contentOffset.y - scrollViewClosedY) / CGFloat(scrollViewOpenY - scrollViewClosedY)
            self.view.bringSubviewToFront(scrollView)
        } else if eventsTableView.contentOffset.y >= -scrollViewClosedY { // Above closed position
            percentScroll = 0
            self.view.bringSubviewToFront(scrollView)
            /*UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                scrollView.contentOffset.x = 0
                }, completion: nil)*/
        } else { // Below open position
            percentScroll = 1
            self.view.sendSubviewToBack(scrollView)
        }
        
        print("percentScroll: \(percentScroll)")
        
        /*
        if scrollView.contentOffset.x != 0{
            print("horizontal scrolled!!")
            eventsTableView.contentInset.top = scrollViewOpenY
            print("contentInset: \(eventsTableView.contentInset.top)")
            eventsTableView.contentOffset.y = -scrollViewOpenY
        }*/
        
        pastEventsLabel.alpha = percentScroll
        
        //STEP 2
        let TX1 = (card1.endOrigin.x - card1.startOrigin.x) * percentScroll
        let TX2 = (card2.endOrigin.x - card2.startOrigin.x) * percentScroll
        let TX3 = (card3.endOrigin.x - card3.startOrigin.x) * percentScroll
        let TX4 = (card4.endOrigin.x - card4.startOrigin.x) * percentScroll
        let TX5 = (card5.endOrigin.x - card5.startOrigin.x) * percentScroll
        let TX6 = (card6.endOrigin.x - card6.startOrigin.x) * percentScroll
        let TX7 = (card7.endOrigin.x - card7.startOrigin.x) * percentScroll
        
        //STEP 3
        let TY1 = (card1.endOrigin.y - card1.startOrigin.y) * percentScroll
        let TY2 = (card2.endOrigin.y - card2.startOrigin.y) * percentScroll
        let TY3 = (card3.endOrigin.y - card3.startOrigin.y) * percentScroll
        let TY4 = (card4.endOrigin.y - card4.startOrigin.y) * percentScroll
        let TY5 = (card5.endOrigin.y - card5.startOrigin.y) * percentScroll
        let TY6 = (card6.endOrigin.y - card6.startOrigin.y) * percentScroll
        let TY7 = (card7.endOrigin.y - card7.startOrigin.y) * percentScroll
        
        //STEP 4
        let R1 = (card1.endRotation - card1.startRotation) * percentScroll
        let R2 = (card2.endRotation - card2.startRotation) * percentScroll
        let R3 = (card3.endRotation - card3.startRotation) * percentScroll
        let R4 = (card4.endRotation - card4.startRotation) * percentScroll
        let R5 = (card5.endRotation - card5.startRotation) * percentScroll
        let R6 = (card6.endRotation - card6.startRotation) * percentScroll
        let R7 = (card7.endRotation - card7.startRotation) * percentScroll
        
        //STEP 5
        let transform1 = CGAffineTransformMakeRotation(card1.startRotation + R1)
        let transform2 = CGAffineTransformMakeRotation(card2.startRotation + R2)
        let transform3 = CGAffineTransformMakeRotation(card3.startRotation + R3)
        let transform4 = CGAffineTransformMakeRotation(card4.startRotation + R4)
        let transform5 = CGAffineTransformMakeRotation(card5.startRotation + R5)
        let transform6 = CGAffineTransformMakeRotation(card6.startRotation + R6)
        let transform7 = CGAffineTransformMakeRotation(card7.startRotation + R7)
        
        //STEP 9
        let translationTransform1 = CGAffineTransformTranslate(transform1, TX1, TY1)
        let translationTransform2 = CGAffineTransformTranslate(transform2, TX2, TY2)
        let translationTransform3 = CGAffineTransformTranslate(transform3, TX3, TY3)
        let translationTransform4 = CGAffineTransformTranslate(transform4, TX4, TY4)
        let translationTransform5 = CGAffineTransformTranslate(transform5, TX5, TY5)
        let translationTransform6 = CGAffineTransformTranslate(transform6, TX6, TY6)
        let translationTransform7 = CGAffineTransformTranslate(transform7, TX7, TY7)
        
        //STEP 10
        housingCardView.transform = translationTransform1
        youthCardView.transform = translationTransform2
        medicineCardView.transform = translationTransform3
        reliefCardView.transform = translationTransform4
        artCardView.transform = translationTransform5
        environmentCardView.transform = translationTransform6
        internationalCardView.transform = translationTransform7
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
        // TO-DO: return number of sections by upcoming time
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 0
        } else {
            return 8
            // TO-DO: return number of rows per upcoming time
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section < 2 {
            if indexPath.row == 0 {
                let row = tableView.dequeueReusableCellWithIdentifier("UserProfileDetailsTableViewCell") as! UserProfileDetailsTableViewCell
                if currentUser != nil {
                    row.nameLabel.text = currentUser!["firstName"] as! String
                    row.locationLabel.text = "\(currentUser!["city"] as! String), \(currentUser!["state"] as! String)"
                    row.bioLabel.text = currentUser!["bio"] as! String
                }
                return row
            } else {
                let row = tableView.dequeueReusableCellWithIdentifier("UserProfileMenuTableViewCell") as! UserProfileMenuTableViewCell
                return row
            }
        } else {
            let row = tableView.dequeueReusableCellWithIdentifier("UserProfileUpcomingAndSavedEventsTableViewCell") as! UserProfileUpcomingAndSavedEventsTableViewCell
            let event = testEvents[0]
            
            // TO-DO: download an image into cell.eventImageView.image
            row.titleLabel.text = event.name
            row.attendeeCountLabel.text = "\(event.attendees.count) people are going"
            
            // Adjusted description line-height
            var attrString: NSMutableAttributedString = NSMutableAttributedString(string: event.description)
            var style = NSMutableParagraphStyle()
            style.lineSpacing = 4
            attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSMakeRange(0, attrString.length))
            row.descriptionLabel.attributedText = attrString;
            
            return row
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return nil
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return nil
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat!
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                height = 220
            } else if indexPath.row == 1 {
                height = 184
            }
        } else {
            height = 111.5
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44
        } else if section == 2 {
            return 44
        } else {
            return 0
        }
    }

}
