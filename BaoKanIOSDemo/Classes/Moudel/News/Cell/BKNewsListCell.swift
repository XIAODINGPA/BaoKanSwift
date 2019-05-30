//
//  BKNewsListCell.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/29.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKNewsListCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(picImageView)
        contentView.addSubview(createDateLabel)

        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(picImageView)
            make.right.equalTo(picImageView.snp_left).offset(-15)

        })
        
        picImageView.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(contentView.snp_right).offset(-5)
            make.size.equalTo(CGSize(width: 75 * 16 / 9, height: 75))
            
        })
        self.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel  = UILabel()
        titleLabel.textColor = .black
        //UIColor.init(white: 53/255, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 02
        return titleLabel
    }()
    
    lazy var createDateLabel: UILabel = {
        let createDateLabel  = UILabel()
        createDateLabel.textColor = UIColor.init(white: 153/255, alpha: 1)
        createDateLabel.font = UIFont.systemFont(ofSize: 13)
        return createDateLabel
    }()
    
    lazy var picImageView: UIImageView = {
        let picImageView = UIImageView()
        picImageView.backgroundColor = UIColor.init(white: 240/255, alpha: 1)
        picImageView.contentMode = UIView.ContentMode.scaleAspectFill
        picImageView.clipsToBounds = true
        return picImageView
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
