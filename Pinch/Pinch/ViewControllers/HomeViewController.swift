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
    
    var cardView: UIView!
    var status: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status = false
        // Do any additional setup after loading the view.
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
        let nav = segue.destinationViewController as! UINavigationController
        let eventDetailViewController = nav.topViewController as! EventViewController
    
        eventDetailViewController.eventSummary = cardView
    }
    

}
