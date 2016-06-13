//
//  UIToggleButtonGroup.swift
//  hows_mom
//
//  Created by Bryan Dunbar on 11/23/15.
//  Copyright © 2015 Vantege. All rights reserved.
//

import UIKit

@objc protocol UIToggleButtonGroupDelegate : NSObjectProtocol {
    
    optional func buttonGroup(group:UIToggleButtonGroup, didSelectIndex newIndex:Int, previousIndex:Int)
}

class UIToggleButtonGroup: UIStackView {

    var delegate:UIToggleButtonGroupDelegate?
    var selectedIndex:Int = -1 {
        didSet {

            // Update states
            for (i, view) in self.arrangedSubviews.enumerate() {
                if let button = view as? UIButton {
                    button.selected = (i == selectedIndex)
                }
            }
            self.setNeedsDisplay()
            
            self.delegate?.buttonGroup?(self, didSelectIndex: selectedIndex, previousIndex:oldValue)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func setUp() {
        setupTouchHandlers()
    }
    
    func setupTouchHandlers() {
        for view:UIView in self.arrangedSubviews {
            
            if let button = view as? UIButton {
                button.addTarget(self, action: #selector(touchUpInside), forControlEvents: .TouchUpInside)
            }
        }
    }
    
    func touchUpInside(sender:UIButton) {
        if let selectedIndex = self.arrangedSubviews.indexOf(sender) {
            self.selectedIndex = selectedIndex
        } else {
            self.selectedIndex = -1
        }
    }


}
