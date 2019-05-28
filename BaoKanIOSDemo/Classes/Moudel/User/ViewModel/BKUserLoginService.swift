//
//  BKUserLoginService.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import Alamofire
class BKUserLoginService: NSObject {
    
    func userLogin(username: String ,password: String) {
        Alamofire.request(URL(string: LOGIN)!, method: .post, parameters: ["username": username,"password":password], encoding: URLEncoding.default , headers: nil).responseJSON { (json) in
            print("** user login name=\(username) + password=\(password) json=\(json)")
        }
    }
}
