//
//  UIViewController+Addition.swift
//  BaoKanIOSDemo
//
//  Created by chen yongfa on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
extension UIViewController {
    
    func convertNav(vc: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: vc)
    }
}
