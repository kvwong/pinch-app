//
//  UserProfileDetailsTableViewCell.swift
//  Pinch
//
//  Created by Cameron Wu on 10/24/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserProfileDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePicImageView.layer.masksToBounds = true
        profilePicImageView.layer.cornerRadius = 46.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
