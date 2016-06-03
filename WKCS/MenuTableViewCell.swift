//
//  MenuTableViewCell.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/3/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var menuText: String? {
        didSet {
            self.label.text = menuText?.uppercaseString
        }
    }

}
