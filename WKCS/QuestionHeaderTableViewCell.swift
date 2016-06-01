//
//  QuestionHeaderTableViewCell.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/1/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class QuestionHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var title:String? {
        didSet {
            self.titleLabel.text = title
        }
    }

}
