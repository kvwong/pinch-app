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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
