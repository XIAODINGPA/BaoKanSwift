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
        navigationItem.title = "首页"
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        addChildView()
        layoutChildView()
        addKVOForTextField()
        loginBtn.isEnabled = false
        // Do any additional setup after loading the view.
        
    }
    
    
    func addNavigatioItem() {
        let closeBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeLoginView))
        navigationItem.leftBarButtonItem = closeBarButtonItem
        
    }
    
    func addChildView() {
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(loginBtn)
        view.addSubview(QQLoginBtn)
        view.addSubview(WeiBoLoginBtn)
    }
    
    func layoutChildView() {
        usernameTF.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(120)
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
            make.height.equalTo(50)
            
        }
        
        // QQ 微博 等间距排列
        let margin = (view.bounds.width - (50 * 2))/3
        QQLoginBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.snp.bottom).offset(-50)
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
        
    }
    
    func addKVOForTextField() {
        usernameTF.addTarget(self, action: #selector(textfieldTextDidChange(textField:)), for: UIControl.Event.editingChanged)
        passwordTF.addTarget(self, action: #selector(textfieldTextDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
    lazy var usernameTF: UITextField = {
        let usernameTF = UITextField()
        usernameTF.text = ""
        usernameTF.delegate = self as! UITextFieldDelegate
        usernameTF.textColor = .black
        usernameTF.backgroundColor = .white
        usernameTF.font = UIFont.systemFont(ofSize: 16)
        usernameTF.attributedPlaceholder = NSMutableAttributedString.init(string: "用户名", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        usernameTF.clearButtonMode = UITextField.ViewMode.whileEditing
        return usernameTF
    }()
    
    lazy var passwordTF: UITextField = {
        let passwordTF = UITextField()
        passwordTF.text = ""
        usernameTF.delegate = self as? UITextFieldDelegate
        passwordTF.textColor = .black
        passwordTF.backgroundColor = .white
        passwordTF.font = UIFont.systemFont(ofSize: 16)
        passwordTF.attributedPlaceholder = NSMutableAttributedString.init(string: "请输入密码", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        passwordTF.clearButtonMode = UITextField.ViewMode.whileEditing
        return passwordTF
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginBtn.addTarget(self, action: #selector(loginAction), for: UIControl.Event.touchUpInside)
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
        
        Alamofire.request(URL(string: LOGIN)!, method: .post, parameters: ["username": username,"password":password], encoding: URLEncoding.default , headers: nil).responseJSON { (json) in
            let message = "** user login \n name=\(username) \n password=\(password) \njson=\(json)"
            print(message)
            let alertC = UIAlertController(title: "请求数据", message: message , preferredStyle: UIAlertController.Style.alert)
            alertC.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self .present(alertC, animated: true, completion: nil)
        }
        //        BKUserLoginService().userLogin(username: username, password: password)
    }
    
    @objc func closeLoginView(){
        print("closeLoginView 点击关闭按钮")
    }
    
    @objc func textfieldTextDidChange(textField: UITextField){
        guard let username :String = usernameTF.text, let passwordTF :String = passwordTF.text else { return  }
        let isEnabled = username.count > 0 && passwordTF.count > 0
        self.loginBtn.isEnabled = isEnabled
        self.loginBtn.backgroundColor =  isEnabled ?  .orange : UIColor.init(white: 0, alpha: 0.2)
        //        UIView.animate(withDuration: 0.1, delay: 0.01, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
        //            self.loginBtn.isEnabled = isEnabled
        //            self.loginBtn.backgroundColor =  isEnabled ?  .orange : UIColor.init(white: 0, alpha: 0.2)
        //        }) { (true) in
        //
        //        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension BKUserLoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(" shouldChangeCharactersIn string = \(string)")
        return true
    }
    
    
}
