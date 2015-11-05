//
//  UserProfileUpcomingAndSavedEventsTableViewCell.swift
//  Pinch
//
//  Created by Cameron Wu on 10/22/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class UserProfileUpcomingAndSavedEventsTableViewCell: NPOCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var attendeeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Event image styles:
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = buttonCornerRadius
        
        // Join button styles:
        joinButton.layer.masksToBounds = true
        joinButton.layer.cornerRadius = buttonCornerRadius
        joinButton.layer.borderWidth = buttonBorderWidth
        joinButton.layer.borderColor = colorBrandGreen.CGColor
        
        // TO-DO: button styles per state
        joinButton.setBackgroundImage(UIImage.imageWithColor(UIColorFromRGB(colorBrandGreenCode, alpha: 0.25)), forState: .Highlighted)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
