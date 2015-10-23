//
//  UpcomingAndSavedEventsTableViewCell.swift
//  Pinch
//
//  Created by Cameron Wu on 10/22/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UpcomingAndSavedEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attendeeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        joinButton.layer.masksToBounds = true
        joinButton.layer.cornerRadius = 4.0
        joinButton.layer.borderWidth = 1.0
        joinButton.layer.borderColor = colorBrandGreen.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
