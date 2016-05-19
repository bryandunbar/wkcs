//
//  AnswerTheCallViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/18/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit
import AVFoundation

class AnswerTheCallViewController: UIViewController, AVAudioPlayerDelegate {

    
    var player:AVAudioPlayer?
    
    @IBOutlet weak var answerCallButton: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
            self.playPhoneRinging()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playPhoneRinging() {
        let phoneRinging = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("phone-ringing", ofType: "mp3")!)
        do {
            try player = AVAudioPlayer(contentsOfURL: phoneRinging)
            player!.prepareToPlay()
            player!.numberOfLoops = 2
            player!.play()
        }  catch _ {
            
        }

    }
    
    func playTheCall() {
        
        if let player = self.player {
            if player.playing {
                player.stop()
            }
        }
        
        let phoneRinging = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("phone-ringing", ofType: "mp3")!)
        do {
            try player = AVAudioPlayer(contentsOfURL: phoneRinging)
            player!.prepareToPlay()
            player!.delegate = self
            player!.numberOfLoops = 1
            player!.play()
        }  catch _ {
            
        }
    }
    
    @IBAction func answerCallTapped(sender: AnyObject) {
        self.playTheCall()
        self.answerCallButton.enabled = false
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            self.answerCallButton.setTitle("Replay the Call", forState: UIControlState.Normal)
            self.answerCallButton.enabled = true
            self.proceedButton.hidden = false
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
