//
//  LoginVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/8.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    
    // MARK: - 控件属性
    
    /// 手机号码输入框
    @IBOutlet weak var mobileTextField: MobileTextField!
    /// 验证码输入框
    @IBOutlet weak var verifyCodeTextField: VerifyCodeTextField!
    /// 验证码视图
    @IBOutlet weak var verifyCodeView: VerifyCodeView!
    /// 验证码输入错误时的提示
    @IBOutlet weak var errorTipView: UIView!
    
    
    var reachbility: Reachability!
    
    //MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configVerifyCodeTextField()
        
    }
    /***** 视图出现之前调用 *****/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //读取上一次登录的手机号
        let lastLoginMobile = UserDefaults.standard.value(forKey: "lastLoginMobile") as? String
        
        if lastLoginMobile == nil {
            mobileTextField.becomeFirstResponder()
        } else {
            mobileTextField.text = lastLoginMobile
            //TODO: - 需要改进，必须手动调用格式化方法才能以344格式显示。
            mobileTextField.formatToMobileNumber()  //344格式化输入框
            verifyCodeTextField.becomeFirstResponder()
        }
        verifyCodeTextField.text = ""
        errorTipView.isHidden = true
    }
    
    /***** 视图出现之后调用 *****/
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shouldShowVerifyCode()
    }
    
    /***** 对象的视图已经消失、被覆盖或是隐藏时调用 *****/
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /// 配置验证码输入框
    private func configVerifyCodeTextField() {
        verifyCodeTextField.delegate = self
        verifyCodeTextField.shouldHideKeyboardWhenEndEdit = true    // 输入完成4位验证码后隐藏键盘
        verifyCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    //MARK: - 按钮事件
    
    //刷新验证码
    @IBAction func btnRefreshCodeTapped(_ sender: UIButton) {
        shouldShowVerifyCode()
    }

    //关闭按钮
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        mobileTextField.resignFirstResponder()
        verifyCodeTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
       ///是否显示验证码。网络可用时，显示验证码，不可用时，不显示。
    private func shouldShowVerifyCode() {
        if reachbility.connection != .unavailable {
            verifyCodeView.generateVerifyCode()
        } else {
            //不可用，不显示验证码。
            SwiftNotice.showText("无法连接网络，请检查网络情况！", autoClear: true, autoClearTime: 1)
            verifyCodeView.clearVerifyCode()
        }
    }
    
    //MARK: - 自定义方法
    
    //输入框内容变化时调用
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField is VerifyCodeTextField && textField.text!.count == 4 {
            if reachbility.connection != .unavailable {
                verifyCode(code: textField.text!)
            } else {
                SwiftNotice.showText("无法连接网络，请检查网络情况！", autoClear: true, autoClearTime: 1)
                textField.text = nil
            }
        }
    }
    
    //验证输入的验证码是否正确
    func verifyCode(code: String) {
        
//        SwiftNotice.waitWithImageAndText(image: #imageLiteral(resourceName: "HUD_Group_41x41_"), text: "加载中...", animated: true)
        
        if code.uppercased() == verifyCodeView.verifyCode!.uppercased() {
        //验证码正确
            errorTipView.isHidden = true
            
            //验证手机号是否正确，如果正确则保存到UserDefaults
            if mobileTextField.text!.isMobileNumber {
                UserDefaults.standard.set(mobileTextField.text!, forKey: "lastLoginMobile")
            } else {
                self.noticeError("手机号错误", autoClear: true, autoClearTime: 1)
                return
            }
            
            //创建User对象
//            UserModel.shared.user = User(mobile: mobileTextField.text!)
            
            self.performSegue(withIdentifier: "ShowSMSVerifyView", sender: nil)
        } else {
        //验证码错误
            errorTipView.isHidden = false
            verifyCodeTextField.text = ""
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSMSVerifyView" {
//            let smsVerifyVC = segue.destination as! SMSVerifyVC
//            smsVerifyVC.mobileNumber = mobileTextField.text
        }
    }
}

extension LoginVC: UITextFieldDelegate {
    
    //验证码输入完成后的回调
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField is VerifyCodeTextField {
            if reachbility.connection != .unavailable {
                verifyCode(code: textField.text!)
            } else {
                SwiftNotice.showText("无法连接网络，请检查网络情况！", autoClear: true, autoClearTime: 1)
                textField.text = nil
            }
        }
    }
}
