//
//  BKNetworkRequest.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/29.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import Alamofire
class BKNetworkRequest: NSObject {

    func get(url: String,parameters:[String:AnyObject],handle:@escaping (Dictionary<String, Any>) -> (Void))  {
        Alamofire.request(URL(string: url)!, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if let error = response.error
            {
                debugPrint("网络异常 error = \n \(error)")
                return
            }
            
            if let data = response.data
            {//NSJSONReadingMutableLeaves
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                debugPrint(json ?? "")
                handle((json as AnyObject) as! Dictionary<String, Any>)
            }

        }
    }
    
    func post(url: String,parameters:[String:AnyObject], handle:@escaping (Dictionary<String, Any>) -> (Void))  {
        listenNetworkStatus()
        Alamofire.request(URL(string: url)!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (response) in
            
            if let error = response.error
            {
                debugPrint("网络异常 error = \n \(error)")
                return
            }
            
            if let data = response.data
            {//NSJSONReadingMutableLeaves
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                debugPrint(json ?? "")
                handle((json as AnyObject) as! Dictionary<String, Any>)
            }

        }
    }
    
    func listenNetworkStatus() {
        let reach = NetworkReachabilityManager(host: "http://www.baokan.tv")
        reach?.listener = { statu in
            debugPrint(statu)
            // case unknown notReachable
            switch statu {
            case .notReachable:
                 debugPrint("**** 网络异常 ****")
//                let alertC = UIAlertController(title: "提示", message: "网络异常", preferredStyle: .alert)
//                alertC.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
////                    alertC.dismiss(animated: true, completion: nil)
//                }))
//                UIApplication.shared.delegate?.window??.rootViewController?.present(alertC, animated: true, completion: nil)
                break
            default: break
                
            }
           
            
            
         
        }
        reach?.startListening()
    }
    
    
}
