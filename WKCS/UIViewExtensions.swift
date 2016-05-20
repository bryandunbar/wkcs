//
//  UIViewExtensions.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/19/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit


extension UIView {
    
    func subviewsOfType(type:AnyClass) -> [UIView] {
        var arr = [UIView]()
        for view in self.subviews {
            if view.isKindOfClass(type) {
                arr.append(view)
            }
        }
        
        return arr
    }
    
}
