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
    
    /// 新闻类目
   fileprivate struct NewsClassItem {
        
        // 类目id
        var classid = ""
        // 类目名
        var classname = ""
        // 构造函数 快速实例NewsClassItem
        init(classid: String,classname: String) {
            self.classid = classid
            self.classname = classname
        }
        
    }
    
    /// 新闻类目数据源
    fileprivate var classItems = [NewsClassItem]()
    
    /// 导航标题数据源
    public var segmentedDataSource: JXSegmentedBaseDataSource?
    
    /// 导航标题视图
    let segmentedView = JXSegmentedView()
    
    /// 导航内容视图
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    /// 导航内容视图底部分割线
    lazy var segmentedLine: UIView = {
        let segmentedLine = UIView()
        segmentedLine.backgroundColor = UIColor.init(white: 242/255, alpha: 1)
        return segmentedLine
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        //添加右侧登录按钮
        addNavigationItem()
        //设置导航标题数据源/样式
        setUpSegmentedTitleDataSource()
        //添加到view上
        setUpSegmentedView()
    
    }
    
    @objc func circleAction() {
        debugPrint("** ** ** ** ")
    }
    
    //MARK: - 重载 视图生命周期
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
        //设置segmentedView listContainerView的位置
        let tabBarHeight = self.tabBarController?.tabBar.bounds.height ?? 0
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 40)
        listContainerView.frame = CGRect(x: 0, y: 40, width: view.bounds.size.width, height: view.bounds.size.height - 40 -  tabBarHeight)
        segmentedLine.frame = CGRect(x: 0, y: segmentedView.frame.maxY - 1/UIScreen.main.scale, width: segmentedView.bounds.width , height: 1/UIScreen.main.scale);
    }
    //MARK: - 私有方法
   fileprivate func addNavigationItem() {
        navigationItem.title = "首页"
        let rightBarBtn = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(tryLogin))
//        rightBarBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        navigationItem.rightBarButtonItem = rightBarBtn
    
    }
    
   fileprivate func setUpSegmentedTitleDataSource() {
        
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = loadNewsClassTitle()
        //reloadData(selectedIndex:)一定要调用
        dataSource.reloadData(selectedIndex: 0)
        self.segmentedDataSource = dataSource
        
       //配置指示器样式
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = .lengthenOffset
        self.segmentedView.indicators = [indicator]
    }
    
   fileprivate func setUpSegmentedView() {
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        view.addSubview(segmentedView)
        
        segmentedView.contentScrollView = listContainerView.scrollView
        listContainerView.didAppearPercent = 0.01
        view.addSubview(listContainerView)
        segmentedView.addSubview(segmentedLine)
    }
   
   /// 数据解析 模型化
   ///
   /// - Returns: 标题数组
   fileprivate func loadNewsClassTitle() -> [String]{
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
    
   /// 数据本地写死
   ///
   /// - Returns: 标题初始数据源
   fileprivate func getClassData() -> [[String:String]] {
        return  [
            [
                "classid" : "0",
                "classname" : "今日头条"
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

        ]
    }
    
}

// MARK: - 此区域存放点击事件
extension BKNewsViewController {
    
    @objc func tryLogin() {
        let loginVC = BKUserLoginViewController()
        self.present(UINavigationController(rootViewController: loginVC), animated: true, completion: nil)
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
        newsListVC.navigationC =  self.navigationController
        newsListVC.relodData(id: classId)
        return newsListVC
    }
}


