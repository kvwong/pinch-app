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
    
    // Outlets & Vars ----------------------------------
    
    // Upcoming & Saved Event Table View
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var cardsScrollView: UIScrollView!
    @IBOutlet weak var cardsScrollViewContent: UIView!
    @IBOutlet weak var housingCardView: UIImageView!
    @IBOutlet weak var youthCardView: UIImageView!
    @IBOutlet weak var medicineCardView: UIImageView!
    @IBOutlet weak var reliefCardView: UIImageView!
    @IBOutlet weak var artCardView: UIImageView!
    @IBOutlet weak var environmentCardView: UIImageView!
    @IBOutlet weak var internationalCardView: UIImageView!
    @IBOutlet weak var pastEventsLabel: UILabel!
    
    let scrollViewClosedY: CGFloat = 150
    let scrollViewOpenY: CGFloat = 208
    
    let currentUser = PFUser.currentUser()
    
    struct Card{
        var startOrigin: CGPoint
        var endOrigin: CGPoint
        var startRotation: CGFloat
        var endRotation: CGFloat
        var view: UIImageView
    }
    
    lazy var cards: [Card] = [
        Card( // blue
            startOrigin: CGPoint(x: 90, y: 30),
            endOrigin: CGPoint(x: 16, y: 64),
            startRotation: radian(-39),
            endRotation: 0,
            view: self.housingCardView),
        Card( // green
            startOrigin: CGPoint(x: 20, y: 60),
            endOrigin: CGPoint(x: 134, y: 64),
            startRotation: radian(-70),
            endRotation: 0,
            view: self.youthCardView),
        Card( // red
            startOrigin: CGPoint(x: 204, y: 92),
            endOrigin: CGPoint(x: 252, y: 64),
            startRotation: radian(79),
            endRotation: 0,
            view: self.medicineCardView),
        Card( // yellow
            startOrigin: CGPoint(x: 158, y: 57),
            endOrigin: CGPoint(x: 370, y: 64),
            startRotation: radian(14),
            endRotation: 0,
            view: self.reliefCardView),
        Card( // purple
            startOrigin: CGPoint(x: 71, y: 92),
            endOrigin: CGPoint(x: 488, y: 64),
            startRotation: radian(-13),
            endRotation: 0,
            view: self.artCardView),
        Card( // dark green
            startOrigin: CGPoint(x: 279, y: 92),
            endOrigin: CGPoint(x: 606, y: 64),
            startRotation: radian(57),
            endRotation: 0,
            view: self.environmentCardView),
        Card( // dark purple
            startOrigin: CGPoint(x: 209, y: 34),
            endOrigin: CGPoint(x: 724, y: 64),
            startRotation: radian(18),
            endRotation: 0,
            view: self.internationalCardView),
    ]
    
    var eventTabsView: UserProfileEventTabsTableViewCell!
    var eventTabsViewInitialY: CGFloat!
    
    var cardsScrollViewInitialX: CGFloat!
    
    
    // Overrides ---------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.frame = self.view.frame

        cardsScrollView.delegate = self
        cardsScrollView.contentSize.width = 847

        // Initialize and style cards
        print("Initalizing cards...")
        for card in cards {
            card.view.frame.origin = card.startOrigin
            card.view.transform = CGAffineTransformMakeRotation(card.startRotation)
            card.view.clipsToBounds = false
            card.view.layer.cornerRadius = 8
            card.view.layer.shadowOffset = CGSize(width: 0, height: 2)
            card.view.layer.shadowOpacity = 0.15
            card.view.layer.shadowRadius = 4
        }
        
        eventTabsView = eventsTableView.dequeueReusableCellWithIdentifier("UserProfileEventTabsTableViewCell") as! UserProfileEventTabsTableViewCell
        eventTabsViewInitialY = 404
        eventTabsView.frame.origin.y = eventTabsViewInitialY - eventsTableView.contentOffset.y
        view.addSubview(eventTabsView)
        
        // Styling
        pastEventsLabel.alpha = 0
        eventsTableView.showsVerticalScrollIndicator = false
        
        // Download data from Parse
        if currentUser != nil {
            var name = currentUser!["firstName"] as! String
            //print("Hello, I'm \(name)")
            self.title = name
            pastEventsLabel.text = "\(name)'s Past Events"
        }

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
        if eventsTableView.contentOffset.y < -scrollViewClosedY + 80 && eventsTableView.contentOffset.y > -(scrollViewClosedY + middlePoint) {
            print("Returning eventsTableView to CLOSED POSITION")
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.eventsTableView.contentInset.top = self.scrollViewClosedY
                self.eventsTableView.contentOffset.y = -self.scrollViewClosedY
                self.pastEventsLabel.alpha = 0
                }, completion: nil)
            
//                self.eventsTableView.contentInset.top = self.scrollViewClosedY
//                self.eventsTableView.contentOffset.y = -self.scrollViewClosedY
//                self.pastEventsLabel.alpha = 0
            
            
        } else if eventsTableView.contentOffset.y < -(scrollViewClosedY + middlePoint) && eventsTableView.contentOffset.y > -scrollViewOpenY {
            print("Returning eventsTableView to OPEN POSITION")
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.eventsTableView.contentInset.top = self.scrollViewOpenY
                self.eventsTableView.contentOffset.y = -self.scrollViewOpenY
                self.pastEventsLabel.alpha = 1
                }, completion: nil)
            
//            self.eventsTableView.contentInset.top = self.scrollViewOpenY
//            self.eventsTableView.contentOffset.y = -self.scrollViewOpenY
//            self.pastEventsLabel.alpha = 1

        }
        self.view.sendSubviewToBack(cardsScrollView)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView == eventsTableView {
            cardsScrollViewInitialX = self.cardsScrollView.contentOffset.x
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var percentScroll: CGFloat!
        
        if scrollView == eventsTableView {
            
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
                eventsTableView.contentInset.top = scrollViewOpenY
            }
            
            // Adjust cards and past events label based on scroll position
            let currentOffset = -1*eventsTableView.contentOffset.y - scrollViewClosedY
            let finalOffset = CGFloat(scrollViewOpenY - scrollViewClosedY)
            if eventsTableView.contentOffset.y < -scrollViewClosedY && eventsTableView.contentOffset.y > -scrollViewOpenY {
                percentScroll = (currentOffset / finalOffset)
                self.view.sendSubviewToBack(cardsScrollView)
                self.view.sendSubviewToBack(pastEventsLabel)
            } else if eventsTableView.contentOffset.y >= -scrollViewClosedY { // Above closed position
                percentScroll = 0
                self.view.sendSubviewToBack(cardsScrollView)
                self.view.sendSubviewToBack(pastEventsLabel)
            } else { // Below open position
                percentScroll = 1
                self.view.bringSubviewToFront(cardsScrollView)
            }
            
            print("percentScroll: \(percentScroll)")
            
            // Return cardsScrollView to origin if left offset
            cardsScrollView.contentOffset.x = cardsScrollViewInitialX * percentScroll
            
            pastEventsLabel.alpha = percentScroll
            
            for card in cards {
                let tx = (card.endOrigin.x - card.startOrigin.x) * percentScroll
                let ty = (card.endOrigin.y - card.startOrigin.y) * percentScroll
                let r = (card.endRotation - card.startRotation) * percentScroll
                let transform = CGAffineTransformMakeRotation(card.startRotation + r)
                let translationTransform = CGAffineTransformTranslate(transform, tx, ty)
                card.view.transform = translationTransform
            }
            
        }
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
