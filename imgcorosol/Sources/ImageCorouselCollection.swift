//
//  ImageCorouselCollection.swift
//  imgcorosol
//
//  Created by Gagan Mac on 11/06/21.
//

import Foundation
import UIKit

open class ImageCorouselCollection: UIView {
    
    open var collectionView: UICollectionView!
    open var items: [ImageCarouseltem]!
    open var pageControll: CustomPageControls!
         
    open override func layoutSubviews() {
        setUpCollectionView()
        setUpPageControll()
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
        collectionView.register(ImageCorouselCell.self, forCellWithReuseIdentifier: "ImageCorouselCell")
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        items = [
            ImageCarouseltem(image: #imageLiteral(resourceName: "james-gillespie-719235-unsplash-1")),
            ImageCarouseltem(image: #imageLiteral(resourceName: "james-gillespie-719235-unsplash-1")),
            ImageCarouseltem(image: #imageLiteral(resourceName: "nemanja-o-718755-unsplash")),
            ImageCarouseltem(image: #imageLiteral(resourceName: "nemanja-o-718755-unsplash")),
            ImageCarouseltem(image: #imageLiteral(resourceName: "james-gillespie-719235-unsplash-1")),
            ImageCarouseltem(image: #imageLiteral(resourceName: "nemanja-o-718755-unsplash")),
            ImageCarouseltem(image: #imageLiteral(resourceName: "james-gillespie-719235-unsplash-1"))
        ]
        addSubview(collectionView)
        collectionView.reloadData()
    }
    
    func setUpPageControll() {
        pageControll = CustomPageControls()
        pageControll.currentPageImage = UIImage(named: "selectedDot")
        pageControll.otherPagesImage = UIImage(named: "unselectedDot")
        pageControll.hidesForSinglePage = items.count == 1
        pageControll.numberOfPages = items.count
        pageControll.frame = CGRect(x: 0, y: bounds.height-20, width: bounds.width, height: 20)
        addSubview(pageControll)
        
    }
    
}
extension ImageCorouselCollection: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCorouselCell", for: indexPath) as! ImageCorouselCell
        cell.imageView.image = items[indexPath.row].image
        return cell
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()

        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size

        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        pageControll.currentPage = indexPath.row

    }
    
}
