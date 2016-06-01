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
    
    
    func setHidden(hidden:Bool, animated:Bool, completion: (() -> Void)?) {
        
        if !animated {
            self.hidden = hidden
            return
        }
        
        // Ensure the proper alpha
        if hidden {
            self.alpha = 1.0
        } else {
            self.alpha = 0.0
            self.hidden = false // Its actually visible, but at 0 alpha
        }

        // Animate the change
        UIView.animateWithDuration(0.4, animations: {
            
            if hidden {
                self.alpha = 0.0
            } else {
                
                self.alpha = 1.0
            }
            
            
            }) { (complete) in
                self.hidden = hidden
                if complete {
                    completion?()
                }
        }
        
    }
    
    func fadeTransition(duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.addAnimation(animation, forKey: kCATransitionFade)
    }
}
