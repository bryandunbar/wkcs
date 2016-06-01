//
//  QuestionTableViewCell.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/1/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var toggleButtonGroup: UIToggleButtonGroup!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var question:String? {
        didSet {
            self.questionLabel.text = question
        }
    }
}
