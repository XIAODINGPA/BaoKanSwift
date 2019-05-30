
//
//  BKUserCenterHeaderView.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/30.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKUserCenterHeaderView: UIView {
    private let titles = ["收藏","评论","资料"]
    private let images = ["profile_topbar_collection","profile_topbar_comment","profile_topbar_info"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        addSubview(loginTextLabel)
        addSubview(contentView)
        for i in 0...titles.count-1 {
            let btn = UIButton(type: .custom)
            btn.tag = 10086 + i
//            btn.frame = CGRect(x: CGFloat(i) * self.bounds.width/3, y: 0, width: self.bounds.width/3, height: 65)
            btn.setTitleColor(.white, for: .normal)
            btn.setTitle(titles[i], for: .normal)
            btn.setImage(UIImage(named: images[i]), for: .normal)
            btn.addTarget(self, action: #selector(clickMenu(btn:)), for: UIControl.Event.touchUpInside)
            contentView.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.width.equalTo(self.bounds.width/3)
                make.height.equalTo(65)
                make.left.equalTo(CGFloat(i) * self.bounds.width/3)

            }
        }
    }
    
    @objc func clickMenu(btn: UIButton){
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top).offset(-55)
        }
        
        loginTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(65)
        }
        self.layoutIfNeeded()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 头像
    lazy var headerImageView: UIImageView = {
        let  headerImageView = UIImageView()
        headerImageView.backgroundColor = UIColor.white
        headerImageView.layer.cornerRadius = 40
        return headerImageView
    }()
    
    /// 登录提示文字
    lazy var loginTextLabel: UILabel = {
        let loginTextLabel = UILabel()
        loginTextLabel.textColor = .white
        loginTextLabel.text = "未登录"
        loginTextLabel.font = UIFont.systemFont(ofSize: 15)
        return loginTextLabel
    }()
    
    /// 菜单背景view
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor(white: 1, alpha: 0.1)
        return contentView
    }()
    
    
    
}
