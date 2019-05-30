//
//  BKCircleSrollView.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/30.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

/// BKCircleSrollViewDelegate协议
public protocol BKCircleSrollViewDelegate: AnyObject {
    
    /// 点击轮播图片
    ///
    /// - Parameter index: 选中图片下标
    /// - Returns: void
    func circleScrollViewDidClick(index: Int) -> Void
}

class BKCircleSrollView: UIView {
    //集合视图复用标识
    let reuseIdentifier = "BKCircleImageCell"
    /// 代理
    weak var delegate: BKCircleSrollViewDelegate?
    var timer: Timer!
    /// 设置图片数据源
    ///
    /// - Parameter images: [String]
    public func setImageArrays(images: Array<String?>){
        imageArray = images
        pageControl.numberOfPages = imageArray.count
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(pageControl)
        startTimer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var imageArray : Array<String?> = {
        let imageArray = [String?]()
        return imageArray
    }()
    
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = self.frame.size
        //水平滚动
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BKCircleImageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
        }
        return collectionView
    }()
 
    lazy var pageControl: UIPageControl = {
       let pageControl = UIPageControl(frame: CGRect(x: self.frame.width/2 - 50, y: self.bounds.height - 30, width: 100, height: 36))
       pageControl.currentPageIndicatorTintColor = UIColor(white: 1, alpha: 0.5)
       pageControl.pageIndicatorTintColor = UIColor(white: 0, alpha: 0.2)
       return pageControl
    }()
    
    func startTimer() {
        timer =  Timer(timeInterval: 2, target: self, selector: #selector(circle), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
     
    }
    
    func invaldTimer() {
       timer.invalidate()
       timer = nil
    }
    
   @objc func circle() {
        debugPrint("------")
    if pageControl.currentPage >= imageArray.count {
        
        return
    }
    collectionView.scrollToItem(at:IndexPath(item: 2, section: 0) , at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
}

extension BKCircleSrollView: UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       self.invaldTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer()
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetX = scrollView.contentOffset.x
//        let page = offsetX / self.bounds.width
//        pageControl.currentPage = Int(page)
//
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = offsetX / self.bounds.width
        pageControl.currentPage = Int(page)
       
    }
}

extension BKCircleSrollView: UICollectionViewDelegate{

    /// 点击cell触发
    ///
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: indexPath
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("BKCircleSrollView: 点击第\(indexPath.row)张轮播图片)")
    }
}

extension BKCircleSrollView: UICollectionViewDataSource{
    
    ///每一组item个数
    ///
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - section: section
    /// - Returns: item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    /// 设置cell样式 赋值
    ///
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: indexPath
    /// - Returns: BKCircleImageCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BKCircleImageCell
        if let url = imageArray[indexPath.row] {
            imageCell?.imageView.setImageWithURL(url: url)
        }
        return imageCell ?? UICollectionViewCell()
    }
    

}
