//
//  EventDetailsViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import SafariServices

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailsView: UIImageView!
    
    // TO-DO: pull this from Parse
    var url = "http://www.gotrbayarea.org/race/51-girls-on-the-run-5k"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = detailsView.image!.size
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressHomepage(sender: AnyObject) {
        let sfViewController = SFSafariViewController(URL: NSURL(string: self.url)!, entersReaderIfAvailable: false)
        self.presentViewController(sfViewController, animated: true, completion: nil)
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
