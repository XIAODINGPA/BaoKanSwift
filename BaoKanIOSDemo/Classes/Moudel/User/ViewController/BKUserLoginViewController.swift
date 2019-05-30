//
//  BKUserLoginViewController.swift
//  BaoKanIOSDemo
//
//  Created by cyf on 2019/5/28.
//  Copyright © 2019 cyf. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
class BKUserLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigatioItem()
        addBlurEffect()
        addChildView()
        layoutChildView()
        addKVOForTextField()
    }
    
    //MARK:- 私有方法
   fileprivate func addNavigatioItem() {
        navigationItem.title = "登录"
        view.backgroundColor = UIColor.init(white: 0.7, alpha: 1)
        let closeBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeLoginView))
        navigationItem.rightBarButtonItem = closeBarButtonItem
        
    }
    
  fileprivate func addBlurEffect() {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "img_login_bg.jpeg")
        view.addSubview(imageView)
        
        // Blur Effect 模糊效果
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        
        //添加到当前view上
        view.addSubview(blurEffectView)
        
        // Vibrancy Effect 生动效果
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = view.bounds
        
        //添加label到vibrancyView的contentView上
        //添加vibrancyView到blurView的contentView上
        blurEffectView.contentView.addSubview(vibrancyEffectView)
    }
    
   fileprivate func addChildView() {
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(loginBtn)
        view.addSubview(QQLoginBtn)
        view.addSubview(WeiBoLoginBtn)
        
        
    }
    
   fileprivate func layoutChildView() {
        usernameTF.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(25)
            } else {
                // Fallback on earlier versions
                make.top.equalToSuperview().offset(25)

            }
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            make.height.equalTo(50)
            
        }
        
        passwordTF.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTF.snp.bottom).offset(25)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            make.height.equalTo(50)
            
        }
        
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTF.snp.bottom).offset(25)
            make.left.equalTo(view).offset(25)
            make.right.equalTo(view).offset(-25)
            make.height.equalTo(55)
            
        }
        
        // QQ 微博 等间距排列
        let margin = (view.bounds.width - (50 * 2))/3
        QQLoginBtn.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            } else {
                make.bottom.equalTo(view.snp.bottom).offset(-50)
                
                // Fallback on earlier versions
            }
            make.left.equalTo(view.snp_left).offset(margin)
            //            make.right.equalTo(view).offset(-(view.bounds.width/2 + 25))
            make.size.equalTo(CGSize(width: 50, height: 50))
            
        }
        
        WeiBoLoginBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(QQLoginBtn.snp_bottom)
            make.right.equalTo(view.snp_right).offset(-margin)
            //            make.left.equalTo(QQLoginBtn.snp_right).offset(25)
            make.size.equalTo(QQLoginBtn.snp_size)
            
        }
        
        firstSepLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(usernameTF.snp.bottom)
            make.left.equalTo(usernameTF)
            make.right.equalTo(usernameTF.snp.right)
            make.height.equalTo(1)
        }
        
        secondSepLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(passwordTF.snp.bottom)
            make.left.equalTo(passwordTF)
            make.right.equalTo(passwordTF.snp.right)
            make.height.equalTo(1)
        }
        
    }
    
   fileprivate func addKVOForTextField() {
        usernameTF.addTarget(self, action: #selector(textfieldTextDidChange(textField:)), for: UIControl.Event.editingChanged)
        passwordTF.addTarget(self, action: #selector(textfieldTextDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
    //MARK:- 懒加载属性
    lazy var usernameTF: UITextField = {
        let usernameTF = UITextField()
        usernameTF.text = ""
        usernameTF.delegate = self as UITextFieldDelegate
        usernameTF.textColor = .black
        usernameTF.font = UIFont.systemFont(ofSize: 18)
        usernameTF.attributedPlaceholder = NSMutableAttributedString.init(string: "用户名", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.init(white: 153/255, alpha: 1)])
        usernameTF.clearButtonMode = UITextField.ViewMode.whileEditing
        return usernameTF
    }()
    
    lazy var passwordTF: UITextField = {
        let passwordTF = UITextField()
        passwordTF.text = ""
        passwordTF.delegate = self as UITextFieldDelegate
        passwordTF.textColor = .black
        passwordTF.isSecureTextEntry = true
        passwordTF.font = UIFont.systemFont(ofSize: 18)
        passwordTF.attributedPlaceholder = NSMutableAttributedString.init(string: "请输入密码", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.init(white: 153/255, alpha: 1)])
        passwordTF.clearButtonMode = UITextField.ViewMode.whileEditing
        return passwordTF
    }()
    
    lazy var firstSepLine: UIView = {
        let firstSepLine = UIView()
        firstSepLine.backgroundColor = UIColor.init(white: 153/255, alpha: 1)
        usernameTF.addSubview(firstSepLine)
        
        return firstSepLine
    }()
    
    lazy var secondSepLine: UIView = {
        let secondSepLine = UIView()
        secondSepLine.backgroundColor = UIColor.init(white: 153/255, alpha: 1)
        passwordTF.addSubview(secondSepLine)
        
        
        return secondSepLine
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.isEnabled = false
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginBtn.addTarget(self, action: #selector(loginAction), for: UIControl.Event.touchUpInside)
        loginBtn.layer.cornerRadius = 8
        return loginBtn
    }()
    
    lazy var QQLoginBtn: UIButton = {
        let QQLoginBtn = UIButton(type: .custom)
        QQLoginBtn.setTitle("QQ登录", for: .normal)
        QQLoginBtn.setImage(UIImage(named: "btn_login_qq"), for: .normal)
        QQLoginBtn.setTitleColor(.gray, for: .normal)
        QQLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        QQLoginBtn.addTarget(self, action: #selector(QQLoginAction), for: UIControl.Event.touchUpInside)
        return QQLoginBtn
    }()
    
    lazy var WeiBoLoginBtn: UIButton = {
        let WeiBoLoginBtn = UIButton(type: .custom)
        WeiBoLoginBtn.setTitle("微博登录", for: .normal)
        WeiBoLoginBtn.setImage(UIImage(named: "btn_login_weibo"), for: .normal)
        WeiBoLoginBtn.setTitleColor(.gray, for: .normal)
        WeiBoLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        WeiBoLoginBtn.addTarget(self, action: #selector(WeiboLoginAction), for: UIControl.Event.touchUpInside)
        return WeiBoLoginBtn
    }()
    
    //MARK: - 点击事件
    /// QQ登陆
    @objc func  QQLoginAction() {
        
    }
    
    /// 微博登陆
    @objc func  WeiboLoginAction(){
        
    }
    
    /// 用户名 密码登录
    @objc func loginAction() {
        
        guard let username = usernameTF.text else {
            let alertC = UIAlertController(title: "提示", message: "用户名不能为空", preferredStyle: UIAlertController.Style.alert)
            alertC.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self .present(alertC, animated: true, completion: nil)
            return
        }
        guard let password = passwordTF.text else {
            let alertC = UIAlertController(title: "提示", message: "密码不能为空", preferredStyle: UIAlertController.Style.alert)
            alertC.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertC, animated: true, completion: nil)
            return
        }
        
        BKNetworkRequest().post(url: LOGIN, parameters: ["username": username as AnyObject ,"password":password as AnyObject ]) { (json) -> (Void) in
            let message = "** user login \n name=\(username) \n password=\(password) \njson=\(json)"
            print(message)
            let alertC = UIAlertController(title: "请求数据", message: message , preferredStyle: UIAlertController.Style.alert)
            alertC.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
                alertC.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertC, animated: true, completion: nil)
        }
        
    }
    
    @objc func closeLoginView(){
        print("closeLoginView 点击关闭按钮")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func textfieldTextDidChange(textField: UITextField){
        guard let username :String = usernameTF.text, let passwordTF :String = passwordTF.text else { return  }
        let isEnabled = username.count > 0 && passwordTF.count > 0
        self.loginBtn.isEnabled = isEnabled
        self.loginBtn.backgroundColor =  isEnabled ?  .red : UIColor.init(white: 0, alpha: 0.2)
        firstSepLine.backgroundColor = username.count > 0 ? .red : UIColor.init(white: 153/255, alpha: 1)
        secondSepLine.backgroundColor = passwordTF.count > 0 ? .red : UIColor.init(white: 153/255, alpha: 1)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension BKUserLoginViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(" shouldChangeCharactersIn string = \(string)")
        return true
    }
    
    
}
