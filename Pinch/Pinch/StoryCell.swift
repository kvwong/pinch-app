//
//  StoryCell.swift
//  Pinch
//
//  Created by Jessie Chen on 11/1/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        storyLabel.text = "Girls on the Run® was established in 1996 in Charlotte, North Carolina. The Girls on the Run® curricula, the heart of the program, provides pre-adolescent girls with the necessary tools to embrace their individual strengths and successfully navigate life experiences. The earliest version of the 24­ lesson curriculum was piloted in 1996 with the help of thirteen brave girls. Twenty-six girls came the next season, then seventy-five. In 2000, Girls on the Run International, a 501c3 organization was born."
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
