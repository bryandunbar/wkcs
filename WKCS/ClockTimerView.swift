//
//  ClockTimerView.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit


@objc protocol ClockTimerViewDelegate : NSObjectProtocol {
    optional func timerExpired(timerView:ClockTimerView)
}

class ClockTimerView: NibDesignable {

    @IBOutlet weak var timerLabel: UILabel!
    var delegate:ClockTimerViewDelegate?
    
    private var timer:NSTimer!
    var timerSeconds:NSTimeInterval! {
        didSet {
            self.updateTimerLabel(self.timerSeconds)
        }
    }
    
    private var tickCount:NSTimeInterval = 0 {
        didSet {
            self.updateTimerLabel(self.tickCount)
        }
    }
    
    func start() {
        self.tickCount = timerSeconds
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    func stop() {
        self.timer?.invalidate()
        self.timer = nil
        
        self.delegate?.timerExpired?(self)
    }
    
    @objc private func update() {
        self.tickCount -= 1
        
        if self.tickCount <= 0 {
            self.stop()
        }
        
    }
    
    func updateTimerLabel(ti:NSTimeInterval) {
        
        if ti <= 0 {
            animateTextChange("--")
        } else {
        
            let dateComponentsFormatter = NSDateComponentsFormatter()
            animateTextChange(dateComponentsFormatter.stringFromTimeInterval(ti)!)
        }

    }
    
    func animateTextChange(newText:String) {
        self.timerLabel.fadeTransition(0.4)
        self.timerLabel.text = newText
    }
}
