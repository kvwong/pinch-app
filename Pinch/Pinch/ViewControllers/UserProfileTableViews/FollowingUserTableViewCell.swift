//
//  FollowingUserTableViewCell.swift
//  Pinch
//
//  Created by Cameron Wu on 10/21/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class FollowingUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Profile picture styles:
        profilePicImageView.layer.masksToBounds = true
        profilePicImageView.layer.cornerRadius = 20.0
        
        // Following button styles:
        followingButton.layer.masksToBounds = true
        followingButton.layer.cornerRadius = 4.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
