//
//  UIViewControllerExtensions.swift
//  WKCS
//
//  Created by Bryan Dunbar on 6/6/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func keyboardWillChangeFrameNotification(notification: NSNotification, block: ((duration:NSNumber, curve:NSNumber, keyboardBeginFrame : CGRect, keyboardEndFrame:CGRect, keyboardOffset:CGFloat) -> Void)?) {
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let keyboardBeginFrameRaw = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let keyboardEndFrameRaw = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let keyboardBeginFrame = self.view.convertRect(keyboardBeginFrameRaw, toView: nil)
        let keyboardEndFrame = self.view.convertRect(keyboardEndFrameRaw, toView: nil)
        
        block?(duration: duration, curve: curve, keyboardBeginFrame: keyboardBeginFrame, keyboardEndFrame: keyboardEndFrame, keyboardOffset:keyboardBeginFrame.origin.y - keyboardEndFrame.origin.y)
        
    }
    
    
    func showError(errorMessage:String, handler:((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Oops!", message: errorMessage, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: handler)
        alert.addAction(defaultAction)
        presentViewController(alert, animated: true, completion:nil)

    }
}