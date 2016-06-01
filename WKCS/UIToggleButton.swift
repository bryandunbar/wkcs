//
//  UIToggleButton.swift
//  hows_mom
//
//  Created by Bryan Dunbar on 11/23/15.
//  Copyright © 2015 Vantege. All rights reserved.
//

import UIKit

@IBDesignable class UIToggleButton: UIButton {
    
   
    
    @IBInspectable var isToggle: Bool = false {
        didSet {
            if isToggle {
                self.addTarget(self, action: Selector("touchUpInside:"), forControlEvents: .TouchUpInside)
            } else {
                self.removeTarget(self, action: Selector("touchUpInside:"), forControlEvents: .TouchUpInside)
            }
        }
    }
    
    
    
    @IBInspectable var backgroundColorNormal: UIColor? {
        didSet {
            backgroundColor = backgroundColorNormal
        }
    }
    @IBInspectable var backgroundColorHighlighted: UIColor?
    var _backgroundColorHighlighted: UIColor? {
        return backgroundColorHighlighted != nil ? backgroundColorHighlighted : backgroundColorNormal
    }
    @IBInspectable var backgroundColorSelected: UIColor?
    var _backgroundColorSelected: UIColor? {
        return backgroundColorSelected != nil ? backgroundColorSelected : _backgroundColorHighlighted
    }
    @IBInspectable var backgroundColorHighlightedSelected: UIColor?
    var _backgroundColorHighlightedSelected: UIColor? {
        return backgroundColorHighlightedSelected != nil ? backgroundColorHighlightedSelected : _backgroundColorHighlighted
    }
    
    override var selected: Bool {
        didSet {
            updateBackgroundState()
        }
    }
    override var highlighted: Bool {
        didSet {
            updateBackgroundState()
        }
    }
    
    func updateBackgroundState() {
        switch (highlighted, selected) {
        case (true, false):
            backgroundColor = _backgroundColorHighlighted
        case (true, true):
            backgroundColor = _backgroundColorHighlightedSelected
        case (false, true):
            backgroundColor = _backgroundColorSelected
        default:
            backgroundColor = backgroundColorNormal
        }
    }
    
    func touchUpInside(sender: UIButton!) {
        selected = !selected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBackgroundState()
    }

}
