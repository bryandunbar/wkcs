//
//  LoginViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/18/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit
import Alamofire

struct LoginData {
    var eventId:Int?
    var user:String?
    var password:String?
    
    func asDictionary() -> [String:AnyObject] {
        return ["event_id": eventId!, "username": user!, "password": password!]
    }
}

class LoginViewController: BaseViewController, UITextFieldDelegate {

    var keyboardShown:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name:UIKeyboardWillHideNotification, object: nil);

    }

    func keyboardWillShow(sender: NSNotification) {
        if !keyboardShown {
            self.keyboardWillChangeFrameNotification(sender, block: { (duration:NSNumber, curve:NSNumber, keyboardBeginFrame:CGRect, keyboardEndFrame:CGRect, keyboardOffset:CGFloat) in
                
                UIView.animateWithDuration(duration.doubleValue, animations: {
                        self.view.frame.origin.y -= keyboardOffset
                    }, completion: { (completed) in
                        if completed {
                            self.keyboardShown = true
                        }
                })
                
            })
            
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if keyboardShown {
            self.keyboardWillChangeFrameNotification(sender, block: { (duration, curve, keyboardBeginFrame, keyboardEndFrame, keyboardOffset) in
                
                UIView.animateWithDuration(duration.doubleValue, animations: {
                    self.view.frame.origin.y -= keyboardOffset
                    }, completion: { (completed) in
                        if completed {
                            self.keyboardShown = false
                        }
                })
            })
        }
    }
    @IBOutlet weak var eventId: UITextField!
    @IBOutlet weak var storeID: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidAppear(animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginTapped(sender: AnyObject) {
        
        let loginData = extractLoginInfo()
        if validate(loginData, forSGM: true) {
            
            
            Alamofire.request(.POST, Constants.API_ENDPOINT + "login", parameters:loginData.asDictionary(), encoding: .JSON)
                .validate()
                .responseJSON { response in
                    debugPrint(response)
                    
                    if let JSON = response.result.value {
                        let status = JSON["status"] as! Bool
                        if status {
                            
                            let result = JSON["result"] as! [String:AnyObject]
                            let profile = result["profile"] as! [String:AnyObject]
                            let location = profile["location"] as! [String:AnyObject]
                            
                            self.updateAppState(loginData.eventId!, location: location, isSGM: true)
                            self.next(sender)
                        } else {
                            self.showError(JSON["error"] as! String, handler: nil)
                        }
                    }

            }
            
        }
        
    }

    @IBAction func loginAsAssociateTapped(sender: AnyObject) {
        
        let loginData = extractLoginInfo()
        if validate(loginData, forSGM: false) {
            
            
            Alamofire.request(.POST, Constants.API_ENDPOINT + "validateEventId", parameters:loginData.asDictionary(), encoding: .JSON)
                .validate()
                .responseJSON { response in
                    debugPrint(response)
                    
                    if let JSON = response.result.value {
                        let status = JSON["status"] as! Bool
                        if status {
                            let result = JSON["result"] as! [String:AnyObject]
                            let profile = result["profile"] as! [String:AnyObject]
                            let location = profile["location"] as! [String:AnyObject]

                            self.updateAppState(loginData.eventId!, location: location, isSGM: false)
                            self.next(sender)
                        } else {
                            self.showError(JSON["error"] as! String, handler: nil)
                        }
                    }
                    
            }
        }
    }
    
    func extractLoginInfo() -> LoginData {
        
        var eventId:Int? = nil
        if let enteredEventId = self.eventId.text {
            eventId = Int(enteredEventId)
        }
        
        return LoginData(eventId: eventId, user: storeID.text, password: password.text)
    }
    
    func updateAppState(eventId:Int, location:[String:AnyObject], isSGM: Bool)  {
        AppController.instance.isSGM = isSGM
        AppController.instance.eventId = eventId
        AppController.instance.location = location
    }
    
    func validate(loginData:LoginData, forSGM:Bool) -> Bool {
        var errorMessage = ""
        
        if loginData.eventId == nil {
            errorMessage += "Event ID is required!\n"
        }
        if loginData.user == nil {
            errorMessage += "Store ID is required!\n"
        }
        if forSGM && loginData.password == nil {
            errorMessage += "Password is required!\n"
        }
        
        let valid = errorMessage.characters.count == 0
        if valid {
            return true
        } else {
            self.showError(errorMessage, handler: nil)
            return false
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.returnKeyType == .Next {
            let tag = textField.tag + 1
            if let view = self.view.viewWithTag(tag) {
                view.becomeFirstResponder()
            }
        } else if textField.returnKeyType == .Go {
            self.loginTapped(UIButton())
        }
        
        return true
    }
    
}

