//
//  RolePlayViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class RolePlayViewController: ScenarioExplanationViewController, ClockTimerViewDelegate {

    @IBOutlet weak var rolePlayBegunButton: UIShadowedButton!
    @IBOutlet weak var clockTimerView: ClockTimerView!
    
    @IBOutlet weak var proceedButton: UIShadowedButton!
    
    override var nextButton: UIButton? {
        get {
            return self.proceedButton
        }
    }
    override func configureView() {
        super.configureView()
        
        self.clockTimerView.delegate = self
        
        if AppController.instance.isSGM {
            descriptionLabel?.text = "Tap here when the participants begin the role play."
            rolePlayBegunButton.hidden = false
            proceedButton.hidden = true
        } else {
            descriptionLabel?.text = "Tap \"Proceed to Debrief\" once the role play has been completed."
            proceedButton.hidden = false
            rolePlayBegunButton.hidden = true
            self.clockTimerView.hidden = true
        }
        
        self.clockTimerView.timerSeconds = step.timerDuration
        self.subtitleLabel?.text = "ROLE PLAY"
    }
    
    func timerExpired(timerView: ClockTimerView) {
        proceedButton.setHidden(false, animated: true, completion: nil)
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
        
        descriptionLabel?.fadeTransition(0.4)
        descriptionLabel?.text = "Tap \"Proceed to Debrief\" once the role play has been completed."
        
        self.clockTimerView.start()
        

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.rolePlayBegunButton.setHidden(true, animated: true, completion: nil)
        })
                
    }
}
