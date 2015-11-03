//
//  PeopleCell.swift
//  Pinch
//
//  Created by Jessie on 10/22/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class PeopleCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Follow button styling
        followButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = buttonCornerRadius
        followButton.layer.borderWidth = buttonBorderWidth
        followButton.layer.borderColor = colorBrandGreen.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onPressedFollow(sender: AnyObject) {
        if followButton.selected == false {
            followButton.selected = true
            followButton.backgroundColor = colorBrandGreen
        } else {
            followButton.selected = false
            followButton.backgroundColor = UIColor.whiteColor()
        }
        
    }
}
