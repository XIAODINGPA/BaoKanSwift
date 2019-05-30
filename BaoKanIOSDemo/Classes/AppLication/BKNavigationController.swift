//
//  BKBaseNavigationController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       let navigationBar =  UINavigationBar.appearance()
       navigationBar.tintColor = .black
       navigationBar.isTranslucent = false
//       navigationBar.barTintColor = UIColor(red: 211/255, green: 57/255, blue: 53/255, alpha: 1)
        // Do any additional setup after loading the view.
    }
   
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController ?? UIViewController()
    }
    
    override var childForStatusBarStyle: UIViewController {
        return self.topViewController ?? UIViewController()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.viewControllers.count > 0){
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)

    }
    
}
