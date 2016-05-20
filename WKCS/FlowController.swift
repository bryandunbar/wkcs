//
//  FlowController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

struct Step : CustomStringConvertible {
    var idx:Int
    var title:String?
    var viewControllerIdentifier:String!
    
    var description: String {
        return "Step \(idx)"
    }
}


class FlowController : NSObject {
    
    var steps:[Step] = []
    var currentStep:Step!
    
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
                        
                        let step:Step = Step(idx: idx,
                                             title: dict["title"] as? String,
                                             viewControllerIdentifier: dict["viewControllerIdentifier"] as? String)
                        
                        steps.append(step)
                    }
                }
            }
            
            // TODO: Save progress....
            currentStep = steps[0]
        }
    }
    
    func getViewControllerForStep(step:Step) -> UIViewController {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.storyboard.instantiateViewControllerWithIdentifier(step.viewControllerIdentifier)
        
    }
    
    func goToNextStep(animated animated:Bool) {
        
        if let nextStep = self.nextStep {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let navigationController = appDelegate.window!.rootViewController as! UINavigationController
            
            self.currentStep = nextStep
            navigationController.pushViewController(getViewControllerForStep(nextStep), animated: animated)
            
        }
        
    }
    
    
}
