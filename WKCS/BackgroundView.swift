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
            self.titleLabel!.text = title
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    @IBInspectable var footerVisible:Bool = true {
        didSet {
            self.footerView!.hidden = !self.footerVisible
        }
    }
    
    override func prepareForInterfaceBuilder() {
        if self.title == nil {
            self.titleLabel!.text = "TITLE"
        }
    }
    
}
