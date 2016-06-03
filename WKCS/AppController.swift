//
//  AppController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/26/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    static var PinkColor = UIColor(red: 169/255, green: 36/255, blue: 57/255, alpha: 1.0)
    static var AlternateRowColor = UIColor(red: 238.0/255, green: 233.0/255, blue: 227.0/255, alpha: 1.0)
}

@objc class AppController: NSObject /*, NSCoding */ {
    
    
    /// Convenience to the NSUserDefaults
    private var userDefaults: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
    /// AppController singleton instance
    class var instance: AppController  {
        struct Singleton {
            static var instance:AppController?
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Singleton.onceToken) {
//            if let archive = NSKeyedUnarchiver.unarchiveObjectWithFile(AppController.archiveFilePath) as? AppController {
//                Singleton.instance = archive
//            }
            
            if Singleton.instance == nil {
                Singleton.instance = AppController()
            }
        }
        return Singleton.instance!
    }
    
    
    var savedStep:Int {
        set {
            userDefaults.setInteger(newValue, forKey: "savedStep")
            userDefaults.synchronize()
        }
        
        get {
            return userDefaults.integerForKey("savedStep")
        }
    }

    
    var user:String? {
        set {
            userDefaults.setObject(newValue, forKey: "savedStep")
            userDefaults.synchronize()
        }
        
        get {
            return userDefaults.objectForKey("savedStep") as? String
        }
    }
    var isSGM:Bool {
        set {
            userDefaults.setBool(newValue, forKey: "isSGM")
            userDefaults.synchronize()
        }
        
        get {
            return userDefaults.boolForKey("isSGM")
        }
    }
    
    
//    func save() -> Bool {
//        return NSKeyedArchiver.archiveRootObject(self, toFile: AppController.archiveFilePath)
//    }
//    
//    class var archiveFilePath:String {
//        get {
//            
//            let docDir:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
//            let docDirNSString:NSString = docDir as NSString
//            return docDirNSString.stringByAppendingPathComponent("WKCS.plist")
//        }
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        self.user = aDecoder.decodeObjectForKey("user") as? String
//        self.isSGM = aDecoder.decodeBoolForKey("isSGM")
//    }
//    // MARK: NSCoding
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(user, forKey: "user")
//        aCoder.encodeBool(isSGM, forKey: "isSGM")
//    }
    
    override init() {
        super.init()
    }
}
