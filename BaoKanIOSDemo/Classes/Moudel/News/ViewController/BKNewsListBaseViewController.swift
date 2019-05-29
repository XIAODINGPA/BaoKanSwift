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
class BKNewsListBaseViewController: UITableViewController {
  
    let reuseIdentifier = "newlist"
    var classId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 90
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BKNewsListCell.self, forCellReuseIdentifier: reuseIdentifier)
        getNewListData(classid: classId)
    }
    
    lazy var dataSource: Array = { () -> [BKNewsListDataModel] in
        let dataSource = [BKNewsListDataModel]()
        return dataSource
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
        cell?.picImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: list.titlepic )!))
        return cell!
    }
    
    func listView() -> UIView {
        return view
    }
}

