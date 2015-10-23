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
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventJoinButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        eventJoinButton.layer.masksToBounds = true
        eventJoinButton.layer.cornerRadius = 4.0
        eventJoinButton.layer.borderWidth = 1.0
        eventJoinButton.layer.borderColor = colorBrandGreen.CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
