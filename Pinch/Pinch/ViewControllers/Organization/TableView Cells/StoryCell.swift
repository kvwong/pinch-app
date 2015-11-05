//
//  StoryCell.swift
//  Pinch
//
//  Created by Jessie Chen on 11/1/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import AFNetworking

//protocol AboutCells: UITableViewCell {
//    weak var organizationProfileViewController: OrganizationProfileViewController! { get set }
//}

//protocol TabTableViewController : UITableViewDataSource, UITableViewDelegate {
//    weak var tableView: UITableView! { get set }
//}


class StoryCell: AboutCellsTableViewCell {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var storyImage: PFImageView!

    var height: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func reloadData() {
        storyLabel.text = organizationProfileViewController.npo.valueForKey("story")! as! String

        //storyLabel.text = "Girls on the Run® was established in 1996 in Charlotte, North Carolina. The Girls on the Run® curricula, the heart of the program, provides pre-adolescent girls with the necessary tools to embrace their individual strengths and successfully navigate life experiences. The earliest version of the 24­ lesson curriculum was piloted in 1996 with the help of thirteen brave girls. Twenty-six girls came the next season, then seventy-five. In 2000, Girls on the Run International, a 501c3 organization was born."
        
        storyLabel.sizeToFit()
        storyImage.frame.origin.y = storyLabel.frame.origin.y + storyLabel.frame.height + 10
        height = Int(storyImage.frame.origin.y + storyImage.frame.height + CGFloat(8))
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(height, forKey: "storycell_height")
        defaults.synchronize()
        
        
        storyImage.file = self.organizationProfileViewController.npo["storyImage"] as? PFFile
        //storyImage.file = organization["storyImage"] as? PFFile
        
        storyImage.loadInBackground()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
