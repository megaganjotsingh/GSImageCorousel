//
//  CustomPageControlls.swift
//  imgcorosol
//
//  Created by Gagan Mac on 11/06/21.
//

import Foundation
import UIKit

open class CustomPageControls: UIPageControl {
    
    
    // MARK: - IBOutlets
    
    var currentPageImage: UIImage?
    var otherPagesImage: UIImage?
    
    // MARK: - Properties
    
    open override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    open override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 14.0, *) {
            defaultConfigurationForiOS14AndAbove()
        } else {
            pageIndicatorTintColor = .clear
            currentPageIndicatorTintColor = .clear
            clipsToBounds = false
        }
    }
    
    
    func updateDots() {
        if #available(iOS 14, *) {
            defaultConfigurationForiOS14AndAbove()
        } else {
            for (index, subview) in subviews.enumerated() {
                let imageView: UIImageView
                if let existingImageview = getImageView(forSubview: subview) {
                    imageView = existingImageview
                } else {
                    imageView = UIImageView(image: otherPagesImage)
                    
                    imageView.center = subview.center
                    subview.addSubview(imageView)
                    subview.clipsToBounds = false
                }
                imageView.image = currentPage == index ? currentPageImage : otherPagesImage
            }
        }
    }
    
    func defaultConfigurationForiOS14AndAbove() {
        if #available(iOS 14.0, *) {
            for index in 0..<numberOfPages {
                let image = index == currentPage ? currentPageImage : otherPagesImage
                setIndicatorImage(image, forPage: index)
            }

            // give the same color as "otherPagesImage" color.
            pageIndicatorTintColor = .white
            
            // give the same color as "currentPageImage" color.
            currentPageIndicatorTintColor = .white
            /*
             Note: If Tint color set to default, Indicator image is not showing. So, give the same tint color based on your Custome Image.
            */
        }
    }
    
    func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        } else {
            let view = view.subviews.first { (view) -> Bool in
                return view is UIImageView
            } as? UIImageView

            return view
        }
    }
}

