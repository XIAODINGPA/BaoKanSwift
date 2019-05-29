
//
//  PHHotNewsViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import JXSegmentedView
class BKHotNewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     view.backgroundColor = .darkGray
        // Do any additional setup after loading the view.
    }
    
 

}

extension BKHotNewsViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
