//
//  ExtensionUIImage.swift
//  Pinch
//
//  Created by Cameron Wu on 10/23/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    class func imageWithColor(color:UIColor?) -> UIImage! {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext();
        
        if let color = color {
            color.setFill()
        } else {
            UIColor.whiteColor().setFill()
        }
        
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
}