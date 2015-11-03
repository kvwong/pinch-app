//
//  SearchFiltersEventLengthTableViewCell.swift
//  Pinch
//
//  Created by Cameron Wu on 10/28/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

@IBDesignable class SearchFiltersEventLengthTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dot1View: UIView!
    @IBOutlet weak var dot2View: UIView!
    @IBOutlet weak var dot3View: UIView!
    @IBOutlet weak var dot4View: UIView!
    @IBOutlet weak var dot5View: UIView!
    @IBOutlet weak var dot6View: UIView!
    @IBOutlet weak var dragger: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Styles
        dot1View.layer.cornerRadius = dot1View.frame.height/2
        dot2View.layer.cornerRadius = dot2View.frame.height/2
        dot3View.layer.cornerRadius = dot3View.frame.height/2
        dot4View.layer.cornerRadius = dot4View.frame.height/2
        dot5View.layer.cornerRadius = dot5View.frame.height/2
        dot6View.layer.cornerRadius = dot6View.frame.height/2
        dragger.layer.cornerRadius = dragger.frame.height/2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
