//
//  PhotoSlider.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/19/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import UIKit

@objc protocol PhotoSliderDelegate : NSObjectProtocol {
    optional func slideChanged(photoSlider:PhotoSlider, oldSlideNumber:Int, newSlideNumber:Int)
}

class PhotoSlider: NibDesignable, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageNumberLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    
    var delegate:PhotoSliderDelegate?
    
    private var images:[UIImage]! = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var currentSlideNumber:Int {
        get {
            return self.pageControl.currentPage
        }
    }
    
    var isFirstSlide:Bool {
        get {
            return self.pageControl.currentPage == 0
        }
    }
    
    var isLastSlide:Bool {
        get {
            return self.images.count == 0 || self.pageControl.currentPage == (self.images.count - 1)
        }
    }
    func setup() {
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = 0
        self.scrollView.delegate = self
        self.layer.masksToBounds = true
        self.imageNumberLabel.hidden = true

    }
    
    override func prepareForInterfaceBuilder() {
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = 4
        self.imageNumberLabel.hidden = false
        self.imageNumberLabel.text = "1"
    
    }
    
    func addImage(image:UIImage) {
        self.images.append(image)
        
        let imageView:UIImageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFit
        self.scrollView.addSubview(imageView)
        self.resetUIControls()
        self.layoutIfNeeded()
    }
    
    func removeImage(image:UIImage) {
        self.resetUIControls()
    }
    
    
    func resetUIControls() {
        self.pageControl.numberOfPages = self.images.count
        self.imageNumberLabel.hidden = self.images.count == 0
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.pageControl.currentPage = Int(currentPage);
        self.imageNumberLabel.text = "\(Int(currentPage + 1))"
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        
        let previousSlide = self.currentSlideNumber
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        self.delegate?.slideChanged?(self, oldSlideNumber: previousSlide, newSlideNumber: Int(currentPage))
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let scrollViewWidth = self.scrollView.frame.size.width
        let scrollViewHeight = self.scrollView.frame.size.height
        for (index, view) in self.scrollView.subviewsOfType(UIImageView.self).enumerate() {
            let rect = CGRectMake(scrollViewWidth * CGFloat(index), 0, scrollViewWidth, scrollViewHeight)
            view.frame = rect.insetBy(dx: 15, dy: 15)
            
        }
        
        self.scrollView.contentSize = CGSizeMake(scrollViewWidth * CGFloat(self.images.count), scrollViewHeight)
        self.resetUIControls()
    }

}
