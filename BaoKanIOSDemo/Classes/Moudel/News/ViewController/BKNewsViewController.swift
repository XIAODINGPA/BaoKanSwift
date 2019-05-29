//
//  BKNewsViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import JXSegmentedView
class BKNewsViewController: UIViewController {
    struct NewsClassItem {
        var classid = ""
        var classname = ""
        
        init(classid: String,classname: String) {
            self.classid = classid
            self.classname = classname
        }
        
    }
    
    var classItems = [NewsClassItem]()
    public var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationItem()
        addSegmentedTitle()
        view.backgroundColor = .white
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        view.addSubview(segmentedView)
        
        segmentedView.contentScrollView = listContainerView.scrollView
        listContainerView.didAppearPercent = 0.01
        view.addSubview(listContainerView)
        segmentedView.addSubview(segmentedLine)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //处于第一个item的时候，才允许屏幕边缘手势返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tabBarHeight = self.tabBarController?.tabBar.bounds.height ?? 0
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 40)
        listContainerView.frame = CGRect(x: 0, y: 40, width: view.bounds.size.width, height: view.bounds.size.height - 40 -  tabBarHeight)
        segmentedLine.frame = CGRect(x: 0, y: segmentedView.frame.maxY - 1/UIScreen.main.scale, width: segmentedView.bounds.width , height: 1/UIScreen.main.scale);
    }
    
    lazy var segmentedLine: UIView = {
        let segmentedLine = UIView()
        segmentedLine.backgroundColor = UIColor.init(white: 242/255, alpha: 1)
        return segmentedLine
    }()
    
    func getNewsClassTitle() -> [String]{
        var classTitles = [String]()
        let dataArray = getClassData()
        for dict in dataArray {
            guard let classid = dict["classid"] else { return [""]}
            guard let classname = dict["classname"] else { return [""]}
            let item = NewsClassItem(classid: classid, classname: classname)
            classItems.append(item)
            classTitles.append(classname)
        }
        return classTitles

    }
    
    func addNavigationItem() {
        navigationItem.title = "首页"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(tryLogin))
    }
    
    func addSegmentedTitle(){
        
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = getNewsClassTitle()
        //reloadData(selectedIndex:)一定要调用
        dataSource.reloadData(selectedIndex: 0)
        self.segmentedDataSource = dataSource
        
//        //配置指示器
//        let indicator = JXSegmentedIndicatorLineView()
//        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
//        indicator.lineStyle = .lengthenOffset
//
//        self.segmentedView.indicators = [indicator]
    }
    
    @objc func tryLogin() {
       let loginVC = BKUserLoginViewController()
       self.present(UINavigationController(rootViewController: loginVC), animated: true, completion: nil)
    }

    //MARK: 数字刷新demo
    @objc func hanldeNumberRefresh()
    {
        if let _segDataSource = segmentedDataSource as? JXSegmentedNumberDataSource {
            let newNumbers = [223, 12, 435, 332, 0, 32, 98, 0, 99999, 112]
            _segDataSource.numberHeight = 18
            _segDataSource.numberOffset = CGPoint(x: -5, y: 5)
            _segDataSource.numbers = newNumbers
            _segDataSource.reloadData(selectedIndex: 0)
            segmentedView.reloadData()
        }
    }
    
    func getClassData() -> [[String:String]] {
        return  [
            [
                "classid" : "0",
                "classname" : "今日头条"
            ],
            [
                "classid" : "2",
                "classname": "网文快讯"
            ],
            [
                "classid" : "21",
                "classname": "媒体视角"
            ],
            [
                "classid" : "12",
                "classname": "网文IP"
            ],
            [
                "classid" : "264",
                "classname": "企业资讯"
            ],
            [
                "classid" : "33",
                "classname": "作家风采"
            ],
            [
                "classid" : "34",
                "classname": "维权在线"
            ],
            [
                "classid" : "212",
                "classname": "业者动态"
            ],
            [
                "classid" : "132",
                "classname": "风花雪月"
            ],
            [
                "classid" : "396",
                "classname": "独家报道"
            ],
            [
                "classid" : "119",
                "classname": "求职招聘"
            ],
        ]
    }
    
}

extension BKNewsViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}

extension BKNewsViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let newsListVC = BKNewsListBaseViewController()
        let classId = classItems[index].classid
        newsListVC.relodData(id: classId)
        return newsListVC
    }
}


