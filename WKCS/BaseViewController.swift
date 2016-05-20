//
//  BaseViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var data:NSDictionary! {
        didSet {
            self.configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        // Configure the next button
        if let button:UIButton? = self.view.viewWithTag(Constants.NEXT_BUTTON_TAG) as? UIButton {
            button?.addTarget(self, action: #selector(next), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
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
