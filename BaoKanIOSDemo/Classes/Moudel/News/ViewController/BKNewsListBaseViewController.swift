//
//  BKNewsListBaseViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/29.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import Alamofire
import JXSegmentedView
import Kingfisher

/// 新闻列表基类
class BKNewsListBaseViewController: UITableViewController {
    
    let reuseIdentifier = "newlist"
    var classId: String!
    var navigationC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 90
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BKNewsListCell.self, forCellReuseIdentifier: reuseIdentifier)
        let headetView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 180))
        headetView.addSubview(circleScroView)
        tableView.tableHeaderView = headetView
        getNewListData(classid: classId)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    lazy var dataSource: Array = { () -> [BKNewsListDataModel] in
        let dataSource = [BKNewsListDataModel]()
        return dataSource
    }()
    //http://www.baokan.tv/d/file/image/20190528/1559008526590040.jpg
    //http://www.baokan.tv/d/file/image/20190528/1559008133936825.jpg
    //http://www.baokan.tv/d/file/image/20190528/1559008526590040.jpg
    lazy var circleScroView: BKCircleSrollView = {
        let circleScroView = BKCircleSrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 180))
        circleScroView.setImageArrays(images: [
            "http://www.baokan.tv/d/file/image/20190528/1559008526590040.jpg",
            "http://www.baokan.tv/d/file/image/20190528/1559008133936825.jpg",
            "http://www.baokan.tv/d/file/n/junshi/2019-05-29/8a70217c39a1c8fbd3e3128e68c3c4dd.jpg"
            ])
        return circleScroView
    }()
    
    public func relodData(id:String) {
        classId = id
        
    }
    
    func getNewListData(classid:String) {
        BKNetworkRequest().get(url: ARTICLE_LIST, parameters: ["classid" : classid as AnyObject]) { json in
            self.dataSource.removeAll()
            if let data = json["data"]{
                debugPrint(data)
                let array = data as! Array<Dictionary<String, AnyObject>>
                for dict in array{
                    let listDataModel = BKNewsListDataModel()
                    listDataModel.title = dict["title"] as! String
                    listDataModel.id = dict["id"] as! String
                    listDataModel.classid = dict["classid"] as! String
                    listDataModel.plnum = dict["plnum"] as! String
                    listDataModel.titlepic = dict["titlepic"] as! String
                    self.dataSource.append(listDataModel)
                }
                
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    
    
    
}

extension BKNewsListBaseViewController:JXSegmentedListContainerViewListDelegate{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = self.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? BKNewsListCell
        cell?.titleLabel.text = list.title
        cell?.picImageView.setImageWithURL(url: list.titlepic)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetail = BKNewsDetailViewController()
        navigationC?.pushViewController(newsDetail, animated: true)
    }
    
    func listView() -> UIView {
        return view
    }
}

