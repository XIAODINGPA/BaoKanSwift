//
//  BKAppConfig.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

/// 配置APP window 根控制器
class BKAppConfig: NSObject {
    let tabbarCtr = BKTabbarController()
    
   func rootViewController() -> UIViewController {
       let news = BKNewsViewController()
       let photoShow = BKPhotoShowViewController()
       let homeNews = BKHotNewsViewController()
       let userCenter = BKProfileViewController()
       let childViewControllers = [news,photoShow,homeNews,userCenter]
       let childTitles = ["首页","图秀","热门","我的"]
       let childImages = ["tabbar_news_normal","tabbar_media_normal","tabbar_reader_normal","tabbar_me_normal"]
       let childSlectesImages = ["tabbar_news_selected","tabbar_media_selected","tabbar_reader_selected","tabbar_me_selected"]

       var i = 0
       for  child in childViewControllers {

            let child = addChildViewController(child: child)
            addTabbarItem(child: child, title: childTitles[i], image: childImages[i], selectedImage: childSlectesImages[i])
            tabbarCtr.addChild(child)

            i += 1
        }
    
       UINavigationBar.appearance().isTranslucent = false
       let tabbar = UITabBar.appearance()
       tabbar.isTranslucent = true
       tabbar.shadowImage = UIImage()
//       tabbar.backgroundImage = UIImage()
       return tabbarCtr
    }
    
    func addChildViewController(child: UIViewController) -> UINavigationController
    {
        let nav = BKNavigationController(rootViewController: child)
        return nav
    }
    
    func addTabbarItem(child: UIViewController, title: String?, image: String? ,selectedImage: String?) {
        let image = UIImage(named: image ?? "")
        let selectedImage = UIImage(named: selectedImage ?? "")
        child.tabBarItem.title = title
        child.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        child.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor : UIColor.lightGray], for: UIControl.State.normal)
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),NSAttributedString.Key.foregroundColor : UIColor.red], for: UIControl.State.selected)
        
    }
}

