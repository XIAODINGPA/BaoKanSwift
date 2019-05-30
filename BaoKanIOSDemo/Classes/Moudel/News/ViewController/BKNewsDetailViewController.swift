


//
//  BKNewsDetailViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/30.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import WebKit
class BKNewsDetailViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Web")
        tableView.tableHeaderView = webView
        
        navigationController?.navigationBar.isTranslucent = false
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelAction))
        
        // Do any additional setup after loading the view.
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never

        } else {
            self.automaticallyAdjustsScrollViewInsets = false

            
        }

    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let c = change{
        
            let size = c[NSKeyValueChangeKey.newKey] as! CGSize
            let webHeight = size.height
            webView.frame = CGRect(x: 0, y: 0, width: webView.bounds.width, height: webHeight)
            tableView.tableHeaderView = webView
            print("**** \(String(describing: c[NSKeyValueChangeKey.newKey])) ****")
        }
       
    }
    
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let bottom = (self.navigationController?.navigationBar.frame.height ?? 0) +  UIApplication.shared.statusBarFrame.height
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - bottom) ,configuration: configuration)
        webView.scrollView.isScrollEnabled = false
        webView.uiDelegate = self as WKUIDelegate
        webView.load(URLRequest(url: URL(string: "https://www.jianshu.com/p/56e40ea56813")!))
        return webView
        //
    }()


    deinit {
        webView.scrollView.removeObserver(self, forKeyPath: "contentSize")

    }
    
}

extension BKNewsDetailViewController: WKUIDelegate{
    
    func  webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return webView
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }

  
}

extension BKNewsDetailViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Web")
        cell?.textLabel?.text = "第\(indexPath.row)行"
        return cell!
    }
}
