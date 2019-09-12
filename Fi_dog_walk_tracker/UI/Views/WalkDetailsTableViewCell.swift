//
//  WalkDetailsTableViewCell.swift
//  Fi_dog_walk_tracker
//
//  Created by Shiv Kalola on 9/11/19.
//  Copyright © 2019 Shiv Kalola. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class WalkDetailsTableViewCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Style game cells
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.layer.borderWidth = CGFloat(10)
        self.layer.borderColor = UIColor.white as! CGColor
        
    }
    
}
