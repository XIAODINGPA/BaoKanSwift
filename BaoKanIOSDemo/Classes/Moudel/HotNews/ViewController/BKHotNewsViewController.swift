
//
//  PHHotNewsViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKHotNewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItem()
        // Do any additional setup after loading the view.
    }
    
    func addNavigationItem() {
        navigationItem.title = "热门"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(tryLogin))
    }
   
    @objc func tryLogin() {
        let loginNavC = UINavigationController(rootViewController: BKUserLoginViewController())
        self.present(loginNavC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
