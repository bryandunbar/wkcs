//
//  LeaderboardTableViewCell.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/13/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var stackView: UIStackView!
    
    var isHeaderCell:Bool = false {
        didSet {
            
        }
    }
    
    var labelText:[String]? {
        didSet {
            self.configureStackView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureStackView() {
        // Remove all subviews first
        for view in self.stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        if let array = self.labelText {
            for s in array {
                let label:UILabel = UILabel()
                label.text = s
                
                if self.isHeaderCell {
                    label.text = label.text?.uppercaseString
                    label.textColor = Theme.OrangeColor
                    label.font = label.font.fontWithSize(30)
                    //label.textAlignment = .Center
                }
                
                self.stackView.addArrangedSubview(label)
            }
        }
    }

}
