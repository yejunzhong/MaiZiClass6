//
//  ScrollImageView.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/19.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

import Kingfisher

class ScrollImageView: UIView, UIScrollViewDelegate {

    var imageURLArray: Array<String>? {

        didSet {
            
            creatImageViews()
            
        }
        
    }
    
    var scrollView : UIScrollView?
    var timer : Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        scrollView?.isPagingEnabled = true
        scrollView?.delegate      = self;
        self.addSubview(scrollView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatImageViews() {
    
        for subview in scrollView!.subviews {
            
            subview.removeFromSuperview()
            
        }
        
        if let count = imageURLArray?.count {
            
            for index in 0..<count {
                
                let imageView = UIImageView()
                imageView.frame = CGRect(x: CGFloat(index) * self.frame.size.width, y: 0 ,width: self.frame.size.width, height: self.frame.size.height)
                
                scrollView!.addSubview(imageView)
                
                if let url = imageURLArray?[index] {
                    
                    imageView.kf.setImage(with: URL.init(string: url)!)
                    
                }
                
            }
            
            let imageLeft = UIImageView.init(frame: CGRect(x: -self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            scrollView!.addSubview(imageLeft)
            
            if let url = imageURLArray?[count - 1] {
                
                imageLeft.kf.setImage(with: URL.init(string: url)!)
                
            }
            
            let imageRight = UIImageView.init(frame: CGRect(x: CGFloat(count) * self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            scrollView!.addSubview(imageRight)
            
            if let url = imageURLArray?[0] {
                
                imageRight.kf.setImage(with: URL.init(string: url)!)
                
            }
            
            scrollView?.contentSize = CGSize(width: CGFloat(count) * self.frame.size.width , height: self.frame.size.height)
            scrollView?.contentInset = UIEdgeInsetsMake(0, self.frame.size.width, 0, self.frame.size.width)
            
        }
        
        if ((self.timer?.isValid) != nil) {
            
            self.timer?.invalidate()
            
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerHanle), userInfo: nil, repeats: true)
    
    }
    
    func timerHanle(){
        
        self.scrollView?.setContentOffset(CGPoint(x: self.scrollView!.contentOffset.x + self.frame.size.width, y: 0), animated: true)
        
    }
    
//    MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let point = scrollView.contentOffset
        
        if point.x == -self.frame.size.width {
            
            scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width - self.frame.size.width, y: 0), animated: false)
            
        }else if point.x == scrollView.contentSize.width {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            
        }
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
