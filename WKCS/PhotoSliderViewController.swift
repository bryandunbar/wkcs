//
//  PhotoSliderViewController.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/19/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

class PhotoSliderViewController: BaseViewController, PhotoSliderDelegate {

    @IBOutlet weak var photoSlider: PhotoSlider!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.photoSlider.addImage(UIImage(named:"scenario1_1")!)
        self.photoSlider.addImage(UIImage(named:"scenario1_2")!)
        self.photoSlider.addImage(UIImage(named:"scenario1_3")!)
        self.photoSlider.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideChanged(photoSlider: PhotoSlider, oldSlideNumber: Int, newSlideNumber: Int) {
        if photoSlider.isLastSlide {
            self.button.hidden = false
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
