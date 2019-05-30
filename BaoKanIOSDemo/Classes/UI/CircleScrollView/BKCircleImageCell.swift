//
//  BKCircleIImageCell.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/30.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKCircleImageCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
}
