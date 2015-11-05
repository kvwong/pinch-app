//
//  PhotosAndVideosCell.swift
//  Pinch
//
//  Created by Jessie Chen on 11/1/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class PhotosAndVideosCell: AboutCellsTableViewCell {
    @IBOutlet weak var image1: PFImageView!
    @IBOutlet weak var image2: PFImageView!
    @IBOutlet weak var image3: PFImageView!
    @IBOutlet weak var image4: PFImageView!
    @IBOutlet weak var image5: PFImageView!
    @IBOutlet weak var image6: PFImageView!
    @IBOutlet weak var image7: PFImageView!
    @IBOutlet weak var image8: PFImageView!
    @IBOutlet weak var image9: PFImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func reloadData() {
        image1.file = self.organizationProfileViewController.npo["media1"] as? PFFile
        image1.loadInBackground()
        image2.file = self.organizationProfileViewController.npo["media2"] as? PFFile
        image2.loadInBackground()
        image3.file = self.organizationProfileViewController.npo["media3"] as? PFFile
        image3.loadInBackground()
        image4.file = self.organizationProfileViewController.npo["media4"] as? PFFile
        image4.loadInBackground()
        image5.file = self.organizationProfileViewController.npo["media5"] as? PFFile
        image5.loadInBackground()
        image6.file = self.organizationProfileViewController.npo["media6"] as? PFFile
        image6.loadInBackground()
        image7.file = self.organizationProfileViewController.npo["media7"] as? PFFile
        image7.loadInBackground()
        image8.file = self.organizationProfileViewController.npo["media8"] as? PFFile
        image8.loadInBackground()
        image9.file = self.organizationProfileViewController.npo["media9"] as? PFFile
        image9.loadInBackground()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
