//
//  UIImage+Addition.swift
//  BaoKanIOSDemo
//
//  Created by chen yongfa on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
extension UIImage {
    
    ///图片渲染保持原图 防止图片被系统渲染成蓝色
    ///
    /// - Returns: UIImage
    func imageAlwaysOriginal() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}
