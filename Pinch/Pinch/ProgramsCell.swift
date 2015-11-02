//
//  ProgramsCell.swift
//  Pinch
//
//  Created by Jessie Chen on 11/1/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class ProgramsCell: UITableViewCell {

    @IBOutlet weak var programsLabel: UILabel!
    @IBOutlet weak var programsImage1: UIImageView!
    @IBOutlet weak var programsImage2: UIImageView!
    
    var height: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        programsLabel.text = "Meeting twice a week in small teams of 8-20 girls, we teach life skills through fun, engaging lessons that celebrate the joy of movement. The 24-lesson curriculum is taught by certified Girls on the Run® coaches and includes three parts: understanding ourselves, valuing relationships and teamwork and understanding how we connect with and shape the world at large. Over the course of the program, girls will develop and improve competence, feel confidence in who they are, develop strength of character, respond to others and oneself with care, create positive connections with peers and adults, and make a meaningful contribution to community and society."
        
        programsLabel.sizeToFit()
        programsImage1.frame.origin.y = programsLabel.frame.origin.y + programsLabel.frame.height + 10
        programsImage2.frame.origin.y = programsImage1.frame.origin.y
        height = Int(programsImage1.frame.origin.y + programsImage1.frame.height + CGFloat(8))
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(height, forKey: "programscell_height")
        defaults.synchronize()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
