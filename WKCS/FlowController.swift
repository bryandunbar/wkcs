//
//  FlowController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit
import CoreGraphics

struct Step : CustomStringConvertible {
    var idx:Int
    var viewControllerIdentifier:String!

    init(idx:Int, viewControllerIdentifier:String) {
        self.idx = idx
        self.viewControllerIdentifier = viewControllerIdentifier
    }
    
    /** Properties on the background view **/
    var title:String?
    var footerVisible:Bool = true
    var keyholeButtonVisible:Bool = true
    var keyholeButtonEnabled:Bool = true
    
    /** Access Control **/
    var forAdminOnly:Bool = false
    
    /** These are all based on the viewController type so optionals **/
    var subtitle:String?
    var subtitle2:String?
    var desc:String?
    var imageName:String?
    var nextButtonTitle:String! = "Proceed"
    var themeColor:UIColor?
    var images:[String]?
    var timerDuration:NSTimeInterval?
    var questions:[[String:AnyObject]]?
    
    var description: String {
        return "Step \(idx)"
    }
}


class FlowController : NSObject {
    
    var steps:[Step] = []
    var currentStep:Step! {
        didSet {
            AppController.instance.savedStep = currentStep.idx // Saves progress
        }
    }
    
    var nextStep:Step? {
        get {
            let idx = self.currentStep.idx
            if idx == (steps.count - 1) {
                return nil
            }
            
            return steps[idx + 1]
        }
    }
    
    class var instance:FlowController {
        struct Singleton {
            static let instance = FlowController()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        
        //TODO: At least read this plist from server
        if let path = NSBundle.mainBundle().pathForResource("WKCS", ofType: "plist") {
            if let arr = NSArray(contentsOfFile: path) {
                for (idx, obj) in arr.enumerate() {
                    if let dict = obj as? NSDictionary {
                        
                        var step:Step = Step(idx: idx,
                                             viewControllerIdentifier: dict["viewControllerIdentifier"] as! String)
                        
                        
                        if let footerVisible = dict["footerVisible"] as? Bool {
                            step.footerVisible = footerVisible
                        }
                        if let keyholeButtonVisible = dict["keyholeButtonVisible"] as? Bool {
                            step.keyholeButtonVisible = keyholeButtonVisible
                        }
                        if let keyholeButtonEnabled = dict["keyholeButtonEnabled"] as? Bool {
                            step.keyholeButtonEnabled = keyholeButtonEnabled
                        }
                        
                        if let title = dict["title"] as? String {
                            step.title = title
                        }
                        if let subtitle = dict["subtitle"] as? String {
                            step.subtitle = subtitle
                        }
                        if let subtitle2 = dict["subtitle2"] as? String {
                            step.subtitle2 = subtitle2
                        }
                        if let desc = dict["description"] as? String {
                            step.desc = desc
                        }
                        
                        if let themeColor = dict["themeColor"] as? String {
                            let comps = themeColor.componentsSeparatedByString(",").map { CGFloat(($0 as NSString).floatValue) / 100.0 }
                            let (r, g, b) = CMYKtoRGB(comps[0], m: comps[1], y: comps[2], k: comps[3])
                            step.themeColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
                        }

                        if let imageName = dict["imageName"] as? String {
                            step.imageName = imageName
                        }
                        if let nextButtonTitle = dict["nextButtonTitle"] as? String {
                            step.nextButtonTitle = nextButtonTitle
                        }
                        
                        if let images = dict["images"] as? [String] {
                            step.images = images
                        }
                        
                        if let timerDuration = dict["timerDuration"] as? NSNumber {
                            step.timerDuration = timerDuration.doubleValue
                        }
                        
                        if let questions = dict["questions"] as? [[String:AnyObject]] {
                            step.questions = questions
                        }
                        
                    
                        steps.append(step)
                    }
                }
            }
            
            currentStep = steps[AppController.instance.savedStep] // Restore progress
        }
    }
    
    func getViewControllerForStep(step:Step) -> BaseViewController {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let vc = appDelegate.storyboard.instantiateViewControllerWithIdentifier(step.viewControllerIdentifier) as! BaseViewController
        vc.step = step
        return vc        
    }
    
    func goToNextStep(animated animated:Bool) {
        
        if let nextStep = self.nextStep {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let navigationController = appDelegate.window!.rootViewController as! UINavigationController
            
            self.currentStep = nextStep
            navigationController.pushViewController(getViewControllerForStep(nextStep), animated: animated)
            
        }
        
    }
    
    func CMYKtoRGB(c : CGFloat, m : CGFloat, y : CGFloat, k : CGFloat) -> (r : CGFloat, g : CGFloat, b : CGFloat) {
        let r = (1 - c) * (1 - k)
        let g = (1 - m) * (1 - k)
        let b = (1 - y) * (1 - k)
        return (r, g, b)
    }
    
    
}
