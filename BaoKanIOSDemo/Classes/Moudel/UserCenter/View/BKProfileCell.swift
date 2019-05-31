//
//  BKProfileCell.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/31.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit

class BKProfileCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(logoImageView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(separatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 25, height: 25))

        }
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.centerY.equalToSuperview()

        }
        
        separatorView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(contentView.snp.right).offset(0)
            make.bottom.equalTo(contentView.snp.bottom).offset(0)
            make.height.equalTo(1/UIScreen.main.scale)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   public lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    public lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.textColor = UIColor(white: 53/255, alpha: 1)
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        return contentLabel
    }()
    
    public lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 242/255, alpha: 1)
        return separatorView
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
