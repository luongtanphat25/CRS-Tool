//
//  ProfileTableViewCell.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-19.
//

import UIKit
import SwipeCellKit

class ProfileTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var crs: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var education: UILabel!
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        crs.layer.cornerRadius = crs.frame.width/2
        crs.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
