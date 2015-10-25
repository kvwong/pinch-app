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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status = false
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
    
    @IBAction func didPressSearchButton(sender: UIButton) {
        performSegueWithIdentifier("segueToSearch", sender: nil)
    }

    @IBAction func onTap(sender: AnyObject) {
        cardView = sender.view as UIView!
        performSegueWithIdentifier("eventDetailSegue", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventDetailSegue" {
            let nav = segue.destinationViewController as! UINavigationController
            let eventDetailViewController = nav.topViewController as! EventViewController
            eventDetailViewController.eventSummary = cardView
        }
    }

}
