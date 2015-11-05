//
//  AboutCellsTableViewCell.swift
//  Pinch
//
//  Created by Jessie Chen on 11/4/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit

class AboutCellsTableViewCell: UITableViewCell {

    var organizationProfileViewController: OrganizationProfileViewController! {
        didSet {
            reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reloadData() {
        
    }

}
