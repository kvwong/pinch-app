//
//  EventViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import MessageUI
import Parse

let offset_HeaderStop:CGFloat = 40.0 // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = 95.0 // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = 35.0 // The distance between the bottom of the Header and the top of the White Label


class EventViewController: UIViewController, MFMailComposeViewControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventSummaryView: UIView!
    
    @IBOutlet weak var eventBannerImage: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTimeAndDateLabel: UILabel!
    @IBOutlet weak var eventAddressLabel: UILabel!
    
    @IBOutlet weak var eventNPOLabel: UILabel!
    
    @IBOutlet weak var eventFriendCountLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    @IBOutlet weak var rsvpButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var tagButton1: UIButton!
    @IBOutlet weak var tagButton2: UIButton!
    @IBOutlet weak var friend1: UIImageView!
    @IBOutlet weak var friend2: UIImageView!
    @IBOutlet weak var friend3: UIImageView!
    
    var index: Int! // Tracks which view is being horizontally scrolled
    
    var summaryBannerImage: UIImage!
    var titleLabel: String!
    var scheduleDate: String!
    var addressLabel: String!
    var npoLabel: String!
    var friend1Image: UIImage!
    var friend2Image: UIImage!
    var friend3Image: UIImage!
    var descriptionLabel: String!
    
    //var eventObjectID: String!
    var event: PFObject!
    //var descriptionIndex: String.CharacterView.Index!
    var npo: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        //scrollView.contentSize.height = eventSummaryView.frame.size.height
        self.navigationController?.navigationBarHidden = true
        scrollView.delegate = self
        eventBannerImage.clipsToBounds = true
        eventBannerImage.clipsToBounds = true
        
        eventBannerImage.image = summaryBannerImage
        eventTitleLabel.text = titleLabel
        eventTimeAndDateLabel.text = scheduleDate
        eventAddressLabel.text = addressLabel
        //eventNPOLabel.text = npoLabel
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        eventDescriptionLabel.attributedText = NSAttributedString(string: descriptionLabel, attributes:[NSFontAttributeName: UIFont(name: "Lato-Regular", size: 14)!, NSForegroundColorAttributeName: colorTextMedium, NSParagraphStyleAttributeName: paragraphStyle])
        
        //npo = event.valueForKey("organization") as! PFObject
        //print("npo: \(npo.valueForKey("name")!)")
        //eventNPOLabel.text = npo.valueForKey("name")! as! String
        
        friend1.image = friend1Image
        friend2.image = friend2Image
        friend3.image = friend3Image
        
        
        tagButton1.layer.cornerRadius = 3
        tagButton2.layer.cornerRadius = 3
        
        // Styling for RSVP button
        rsvpButton.layer.masksToBounds = true
        rsvpButton.layer.cornerRadius = buttonCornerRadius
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTapNPO(sender: AnyObject) {
        print("NPO Profile")
        performSegueWithIdentifier("segueToNPO", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToNPO" {
            
        let npoVC = segue.destinationViewController as! OrganizationProfileViewController
            
        npoVC.npo = npo
            
        }}
    
    
    /*func scrollViewDidScroll(scrollView: UIScrollView) {
    
    let offset = scrollView.contentOffset.y
    var avatarTransform = CATransform3DIdentity
    var headerTransform = CATransform3DIdentity
    
    // PULL DOWN -----------------
    
    if offset < 0 {
    
    let headerScaleFactor:CGFloat = -(offset) / eventBannerImage.bounds.height
    let headerSizevariation = ((eventBannerImage.bounds.height * (1.0 + headerScaleFactor)) - eventBannerImage.bounds.height)/2.0
    headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
    headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
    
    eventBannerImage.layer.transform = headerTransform
    }
    
    // SCROLL UP/DOWN ------------
    
    else {
    
    // Header -----------
    
    headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
    
    //  ------------ Label
    
    let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
    eventTitleLabel.layer.transform = labelTransform
    
    //  ------------ Blur
    
    //headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
    
    // Avatar -----------
    /*
    let avatarScaleFactor = (min(offset_HeaderStop, offset)) / avatarImage.bounds.height / 1.4 // Slow down the animation
    let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
    avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
    avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
    
    if offset <= offset_HeaderStop {
    
    if avatarImage.layer.zPosition < header.layer.zPosition{
    header.layer.zPosition = 0
    }
    
    }else {
    if avatarImage.layer.zPosition >= header.layer.zPosition{
    header.layer.zPosition = 2
    }
    }
    */
    }
    
    // Apply Transformations
    
    eventBannerImage.layer.transform = headerTransform
    //avatarImage.layer.transform = avatarTransform
    }*/
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressShare(sender: AnyObject) {
        // Show actionsheet
        var sharingItems = [AnyObject]()
        sharingItems.append("A real URL would go here.")
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func onPressSaved(sender: AnyObject) {
        if saveButton.selected == false {
            saveButton.selected = true
            saveButton.transform = CGAffineTransformMakeScale(0.2, 0.2)
            UIView .animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 7.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.saveButton.transform = CGAffineTransformIdentity
                }, completion: nil)
            
        } else if saveButton.selected == true {
            saveButton.selected = false
        }
    }
    
    @IBAction func onBannerTap(sender: AnyObject) {
        performSegueWithIdentifier("Expand Banner", sender: nil)
    }
    
    @IBAction func onPressPhone(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://14153214567")!)
        print("dialing")
    }
    
    @IBAction func onComposeEmail(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients(["runningbuddy@gotsrf.org"])
        mailComposerVC.setSubject("Message About Girls on the Run")
        mailComposerVC.setMessageBody("", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
