//
//  ScanTimeoutVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/31.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 扫描超时
class ScanTimeoutVC: UIViewController {
    
    // MARK: - 控件属性
    /// 文本输入框
    @IBOutlet weak var inputTextField: UITextField!
    
    /// 继续按钮
    @IBOutlet weak var continueBtn: UIButton!
    
    /// 底层View
    @IBOutlet weak var bottomView: UIView!
    
    /// 手电筒按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func FlashlightBtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected  //按钮状态取反
        print("手电筒按钮点击事件")
        
        TurnOnFlashlight()
    }
    
    /// 关闭按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        
        self.view.removeFromSuperview()                                 // 移除父视图
        parent?.navigationController?.navigationBar.isHidden = false    // 父视图控制器的导航栏不隐藏
        self.removeFromParent()                           // 从父视图控制器中移除
        
    }
    
    
    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册键盘通知
        /**
         *参数一：注册观察者对象，参数不能为空
         *参数二：收到通知执行的方法，可以带参
         *参数三：通知的名字
         *参数四：收到指定对象的通知，没有指定具体对象就写nil
         */
//        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChanged), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // 创建点击手势, 并添加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        bottomView.addGestureRecognizer(tapGesture)
    }
    
    // 视图即将可见时, 调用
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configTexField()
    }
    
    /// 视图即将消失时, 加载
    ///
    /// - Parameter animated: 是否动画
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
   
        //注销键盘通知
        /**
         *参数一：注销观察者对象，参数不能为空
         *参数二：通知的名字
         *参数四：收到指定对象的通知，没有指定具体对象就写nil
         */
    
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
       
    }
  
}

// MARK: - 配置UI
extension ScanTimeoutVC {
    
    /// 配置文本输入框
    fileprivate func configTexField() {
        inputTextField.layer.cornerRadius = 20
        inputTextField.layer.borderWidth = 2
        inputTextField.layer.borderColor = ofoWholeColor.cgColor
        inputTextField.delegate = self
        inputTextField.becomeFirstResponder()
        
        
        // allEditingEvents: 所有编辑事件
        inputTextField.addTarget(self, action: #selector(textFieldDidChanged(textField:)), for: .allEditingEvents)  
    }
}

// MARK: - 事件监听
extension ScanTimeoutVC {
    
    
    /// 键盘即将隐藏 (收起)
    @objc fileprivate func keyboardWillHide() {
        inputTextField.resignFirstResponder()       // 辞去第一响应者 (收起键盘)
//        self.bottomView.transform = .identity   // 恢复 (往下平移 键盘的高度)
//        self.bottomView.transform = CGAffineTransform(translationX: 0, y: 30)
//        self.continueBtn.transform = CGAffineTransform(translationX: 0, y: 30)
    }

    /// 根据输入框文字的个数，设置tipLabel的内容，以及按钮的状态
    ///
    /// - Parameter textField: 文本输入框
    @objc func textFieldDidChanged(textField: UITextField) {
        let text = textField.text ?? ""
        
        if text.isEmpty {                   // 如果文本输入框文字为空, 设置按钮状态\背景色
            /// 继续按钮背景色
            let continueBtnColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.00)
            continueBtn.isEnabled = false
            continueBtn.backgroundColor = continueBtnColor
        } else {
            continueBtn.isEnabled = true
            continueBtn.backgroundColor = ofoWholeColor
        }
        
    }
}

// MARK: - UITextFieldDelegate
extension ScanTimeoutVC: UITextFieldDelegate {
    
    /// 功能：把textField中位置为range的字符串替换为string字符串, 此函数在textField内容被修改时调用
    ///
    /// - Parameters:
    ///   - textField: 响应UITextFieldDelegate协议的UITextField控件。
    ///   - range: UITextField控件中光标选中的字符串，即被替换的字符串；
    ///   - string: 替换字符串. string.length为0时，表示删除
    /// - Returns: 　true:表示修改生效. false:表示不做修改，textField的内容不变。
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard range.location < 11 else {
            return false
        }
        return true
    }
    
}

