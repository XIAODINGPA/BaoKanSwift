//
//  BKUserCenterViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKProfileViewController: UITableViewController {
    let reuseIdentifier = "BKProfileViewCell"
    struct UserProfileItem {
        var image: String?
        var title: String = ""
        var hiddenLine: Bool = false
        var arrow: Bool = true
        var info: Bool = false
        
    }
    
    init() {
        super.init(style: UITableView.Style.grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor(white: 242/255, alpha: 1)
        tableView.register(BKProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableHeaderView = headerView
        view.backgroundColor = tableView.backgroundColor
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        loadData()
        profileHeaderEvent()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    lazy var headerView: BKProfileHeaderView = {
        let headerView = BKProfileHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 260))
        headerView.backgroundColor = UIColor(red: 197/255 , green: 60/255, blue: 60/255, alpha: 1)
        return headerView
    }()
    
    var dataSource  = [UserProfileItem]()
    func loadData() {
        dataSource.append(UserProfileItem(image: "profile_clear_icon", title: "清除缓存", hiddenLine: false, arrow: true, info: false))
        dataSource.append(UserProfileItem(image: "profile_duty_icon", title: "正文字体", hiddenLine: false, arrow: true, info: false))
        dataSource.append(UserProfileItem(image: "profile_feedback_icon", title: "意见反馈", hiddenLine: false, arrow: true, info: false))
        dataSource.append(UserProfileItem(image: "profile_help_icon", title: "关于我们", hiddenLine: false, arrow: true, info: false))
        dataSource.append(UserProfileItem(image: "profile_share_icon", title: "推荐给好友", hiddenLine: false, arrow: true, info: false))
        dataSource.append(UserProfileItem(image: "profile_upload_icon", title: "当前版本", hiddenLine: true, arrow: true, info: true))
    }

    //监听头部按钮点击事件
    func profileHeaderEvent() {
        headerView.profileHeaderViewBlock = { event in
            //先检查用户登录状态
            switch event {
            case .collection:
                debugPrint("点击收藏")
                break
            case .comment:
                debugPrint("点击评论")
                break
            case .info:
                debugPrint("点击资料")
                break
            default:
                break
            }
        }
    }
}

extension BKProfileViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("dataSource count == \(self.dataSource.count)")
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! BKProfileCell
        let item = dataSource[indexPath.row]
        cell.selectionStyle = .none
        cell.logoImageView.image = UIImage(named: item.image ?? "profile_clear_icon")
        cell.contentLabel.text = item.title
//        cell.accessoryType = .disclosureIndicator
        return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
//    
//   override func tableView(_ tableView: UITableView, heightForHeaderInFooter section: Int) -> CGFloat {
//        return 0.01
//    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 10))
        header.backgroundColor = tableView.backgroundColor
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

