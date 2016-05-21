//
//  UIRoundedCornerView.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/19/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

@IBDesignable class UIRoundedCornerView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @IBInspectable var borderColor:UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.CGColor
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.layoutIfNeeded()
        }
    }
    
    func setup() {
        self.layer.cornerRadius = self.cornerRadius;
    }
    
    @IBInspectable var cornerRadius:CGFloat = 5.0 {
        didSet {
            self.layer.masksToBounds = true
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.cornerRadius

    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }


}
