//
//  LoginViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/18/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginTapped(sender: AnyObject) {
        AppController.instance.isSGM = true
        self.next(sender)
    }

    @IBAction func loginAsAssociateTapped(sender: AnyObject) {
        AppController.instance.isSGM = false
        self.next(sender)
    }
}

