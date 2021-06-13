//
//  ImageCorouselCell.swift
//  imgcorosol
//
//  Created by Gagan Mac on 11/06/21.
//

import Foundation
import UIKit


class ImageCorouselCell: UICollectionViewCell {
        
    fileprivate var _imageView: UIImageView?
    
    @objc
    var imageView: UIImageView! {
        if let imgView = _imageView {
            return imgView
        }
        let imgV = UIImageView(frame: CGRect.zero)
        self.contentView.addSubview(imgV)
        _imageView = imgV
        return imgV
    }
    
    
    override class func awakeFromNib() {
//        commonInit()
    }
    
    func commonInit() {
        
    }
    
    override func layoutSubviews() {
        if let imgV = _imageView {
            imgV.frame = contentView.bounds
        }
    }
}

