//
//  SearchFiltersEventDistanceTableViewCell.swift
//  Pinch
//
//  Created by Cameron Wu on 10/28/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

@IBDesignable class SearchFiltersEventDistanceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dot1View: UIView!
    @IBOutlet weak var dot2View: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Styles
        dot1View.layer.cornerRadius = dot1View.frame.height/2
        dot2View.layer.cornerRadius = dot2View.frame.height/2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
