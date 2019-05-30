//
//  File.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/30.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
   public func setImageWithURL(url: String) {
        if url.isEmpty {
            assert(true, "图片地址为空")
        }
        let downloadURL = URL(string: url)!
        let resource = ImageResource(downloadURL: downloadURL)
        self.kf.setImage(with: resource)
//        self.setImageWithURL(url: url, placeholder: nil)
    }
    
    public func setImageWithURL(url: String,placeholder: String) {
        if url.isEmpty || url.count == 0{
            return
        }
        let downloadURL = URL(string: url)!
        let placeholder = UIImage(named: placeholder)
        let resource = ImageResource(downloadURL: downloadURL)
    
        self.kf.setImage(with: resource, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    
}
