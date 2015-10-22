//
//  EventViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventSummaryView: UIView!
    @IBOutlet weak var wireframeImage: UIImageView!
    
    @IBOutlet weak var eventBannerImage: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTimeAndDateLabel: UILabel!
    @IBOutlet weak var eventAddressLabel: UILabel!
    
    @IBOutlet weak var eventNPOLabel: UILabel!
    
    @IBOutlet weak var eventFriendCountLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    var eventSummary: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wireframeImage.alpha = 0.1
        scrollView.contentSize.height = eventSummaryView.frame.size.height
        self.navigationController?.navigationBarHidden = true
        
        eventSummaryView = eventSummary
        
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func didPressCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func onBannerTap(sender: AnyObject) {
        performSegueWithIdentifier("Expand Banner", sender: nil)
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
