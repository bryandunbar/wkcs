//
//  RolePlayViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class RolePlayViewController: BaseViewController {

    @IBOutlet weak var rolePlayBegunButton: UIShadowedButton!
    @IBOutlet weak var clockTimerView: ClockTimerView!
    
    
    override func configureView() {
        self.clockTimerView.timerSeconds = step.timerDuration
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func rolePlayBegunTapped(sender: AnyObject) {
        
        self.clockTimerView.start()
        self.rolePlayBegunButton.hidden = true
        
    }
}
