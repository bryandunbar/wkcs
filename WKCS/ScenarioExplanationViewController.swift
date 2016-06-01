//
//  ScenarioExplanationViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class ScenarioExplanationViewController: BaseViewController {

    
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var subtitle2Label: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    override func configureView() {
        super.configureView()
        
        //self.subtitleLabel.hidden = step.subtitle == nil
        //self.descriptionLabel.hidden = step.desc == nil
        //self.subtitle2Label.hidden = step.subtitle2 == nil
        
        if let color = step.themeColor {
            self.subtitleLabel?.backgroundColor = color
            self.subtitle2Label?.textColor = color
        }
        
        self.subtitleLabel?.text = step.subtitle?.uppercaseString
        self.subtitle2Label?.text = step.subtitle2?.uppercaseString
        self.descriptionLabel?.text = step.desc
    
        if let imageName = step.imageName {
            self.imageView?.image = UIImage(named: imageName)
        }
        
    }
    
}
