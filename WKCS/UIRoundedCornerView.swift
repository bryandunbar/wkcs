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
    
    func setup() {
        self.layer.cornerRadius = self.cornerRadius;
    }
    
    @IBInspectable var cornerRadius:CGFloat = 5.0 {
        didSet {
            self.layer.masksToBounds = true
            setNeedsLayout()
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
