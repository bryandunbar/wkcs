//
//  BaseViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet var backgroundView: BackgroundView?
    
    var step:Step!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    var nextButton:UIButton? {
        get {
            return self.view.viewWithTag(Constants.NEXT_BUTTON_TAG) as? UIButton
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        // Configure the next button
        if let button = self.nextButton {
            button.addTarget(self, action: #selector(next), forControlEvents: .TouchUpInside)
            button.setTitle(step.nextButtonTitle, forState: .Normal)
        }
        
        self.backgroundView?.title = self.step.title
        self.backgroundView?.footerVisible = self.step.footerVisible
        self.backgroundView?.keyholeButtonEnabled = self.step.keyholeButtonEnabled
        self.backgroundView?.keyholeButtonVisible = self.step.keyholeButtonVisible
    }
    
    @IBAction func next(sender:AnyObject) {
    
        let fc = FlowController.instance
        fc.goToNextStep(animated: true)
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
