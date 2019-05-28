//
//  ViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import Alamofire
class BKViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(URL(string: "http://www.baokan.tv/e/bpi/getNewsList.php")!).responseJSON { (json) in
            print("json == \(json)");
        }
        // Do any additional setup after loading the view.
    }
}

