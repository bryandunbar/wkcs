//
//  BackgroundView.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/18/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class BackgroundView: NibDesignable {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    @IBInspectable var title:String? {
        didSet {
            self.titleLabel!.text = title?.uppercaseString
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var keyholeButton: UIButton!
    
    @IBInspectable var footerVisible:Bool = true {
        didSet {
            self.footerView!.hidden = !self.footerVisible
        }
    }
    
    @IBInspectable var keyholeButtonEnabled:Bool = true {
        didSet {
            self.keyholeButton!.userInteractionEnabled = self.keyholeButtonEnabled
        }
    }
    
    @IBInspectable var keyholeButtonVisible:Bool = true {
        didSet {
            self.keyholeButton!.hidden = !self.keyholeButtonVisible
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        if self.title == nil {
            self.titleLabel!.text = "TITLE"
        }
    }
    
}
