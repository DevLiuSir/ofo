//
//  InputCarLicenseController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/23.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit


/// 键盘高度
private let keyboardHeight: CGFloat = 216.0

/// 输入车牌号控制器
class InputCarLicenseController: UIViewController {
    
    // MARK: - 控件属性
    
    /// 底部View
    @IBOutlet weak var bottomView: UIView!
    
    /// 提示文本(输入车牌号)
    @IBOutlet weak var reminderLabel: UILabel!
    
    /// 输入车牌号文本框
    @IBOutlet weak var InputTextField: UITextField!
    
    /// 立即用车
    @IBOutlet weak var ImmediatelyCar: UIButton!
    
    /// 手电筒
    @IBOutlet weak var FlashlightBtn: UIButton!
    
    /// 声音
    @IBOutlet weak var VoiceBtn: UIButton!
    
    /// 扫码解锁
    @IBOutlet weak var ScanCodeBtn: UIButton!
    
    // MARK: - 按钮点击事件
    /// 手电筒按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func FlashlightBtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected  //按钮状态取反
        print("手电筒按钮点击事件")
        
        TurnOnFlashlight()
    }
    
    /// 声音按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func VoiceBtnTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected  //按钮状态取反
        print("声音按钮点击事件")
    }

    
    /// 扫码解锁按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func ScanCodeBtnTap(_ sender: UIButton) {
        
        scanQRCodeTap()
        print("扫码解锁按钮点击事件")
    }
    
    /// 关闭界面按钮
    ///
    /// - Parameter sender: 按钮
    @IBAction func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)   // 返回上一级控制器
    }
    
    // MARK: - 懒加载
    /// 自定义文本输入框内占位符, 使得光标居中占位符
    fileprivate lazy var customPlaceholderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 105, y: 0, width: 200, height: 40))
        label.text = "请输入车牌号"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        // 注册键盘通知
        /**
         *参数一：注册观察者对象，参数不能为空
         *参数二：收到通知执行的方法，可以带参
         *参数三：通知的名字
         *参数四：收到指定对象的通知，没有指定具体对象就写nil
         */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
    }
    
    /// 视图即将可见时, 加载
    ///
    /// - Parameter animated: 是否动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        super.becomeFirstResponder()            // 成为第一响应者 (弹出键盘)
    }
   
    /// 视图即将消失时, 加载
    ///
    /// - Parameter animated: 是否动画
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        InputTextField.resignFirstResponder()     // 辞去第一响应者 (收起键盘)
        
        //注销键盘通知
        /**
         *参数一：注销观察者对象，参数不能为空
         *参数二：通知的名字
         *参数四：收到指定对象的通知，没有指定具体对象就写nil
         */
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
}


// MARK: - 配置UI
extension InputCarLicenseController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        reminderLabel.adjustsFontForContentSizeCategory = true   // 根据文本内容自动调整标签的宽度
        
        // 创建点击手势, 并添加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        bottomView.addGestureRecognizer(tapGesture)
        
        configTextField()
        configImmediatelyCarBTN()
    }
    
    /// 配置文本输入框
    private func configTextField() {
        InputTextField.layer.cornerRadius = 15                       // 设置边框圆角
        InputTextField.layer.masksToBounds = true                    // 是否裁边
        InputTextField.layer.borderWidth = 1.5                       // 设置文本输入框的边框宽度
        InputTextField.layer.borderColor = ofoWholeColor.cgColor     // 设置文本输入框的边框颜色
        InputTextField.becomeFirstResponder()                        // 成为第一响应者 (弹出键盘)
        InputTextField.delegate = self
        InputTextField.addSubview(customPlaceholderLabel)
        
        
        // 文本输入框 左边填充 文本输入框的一半
//        InputTextField.setValue(NSNumber(value: Float(InputTextField.bounds.width * 0.5)), forKey: "paddingLeft")
//        let leftV = UILabel(frame: CGRect(x: 0, y: 0, width: InputTextField.bounds.width * 0.5, height: 26))
//
//        leftV.backgroundColor = .clear
//        InputTextField.leftView = leftV
//        InputTextField.leftViewMode = .always
     
/*
        // 文本字段文本的开头
        let startPosition: UITextPosition = InputTextField.beginningOfDocument
        
        // 文本字段文本的最后结尾
        let endPosition: UITextPosition = InputTextField.endOfDocument
        
        //当前选择的范围
        let selectedRange: UITextRange? = InputTextField.selectedTextRange
        
        //到任意位置
        
        //从开始，向右移动3个字符。
        
        let arbitraryValue: Int = 3
        
        if let newPosition = InputTextField.position(from: startPosition, offset: arbitraryValue) {
            
            InputTextField.selectedTextRange = InputTextField.textRange(from: newPosition, to: newPosition)
        }
 */
/*
        //获取光标位置
        if let selectedRange = InputTextField.selectedTextRange {
            
            let cursorPosition = InputTextField.offset(from: InputTextField.beginningOfDocument, to: selectedRange.start)
            print("\(cursorPosition)")
        }
        
*/
        //一开始
        
//        let newPosition = InputTextField.beginningOfDocument
//        InputTextField.selectedTextRange = InputTextField.textRange(from: newPosition, to: newPosition)
//        
//        //到最后
//        let newPosition = InputTextField.endOfDocument
//        InputTextField.selectedTextRange = InputTextField.textRange(from: newPosition, to: newPosition)
//        
//
    }

    /// 配置立即用车按钮
    private func configImmediatelyCarBTN() {
        ImmediatelyCar.layer.cornerRadius = 15
        ImmediatelyCar.layer.masksToBounds = true
    }
}

// MARK: - 事件监听
extension InputCarLicenseController {
    
    /// 点击扫描二维码
    fileprivate func scanQRCodeTap() {
        
        // 获取storyboard
        let storyBoard = UIStoryboard(name: "QRCodeController", bundle: nil)
        let qrcodeVC = storyBoard.instantiateInitialViewController()
        
        // 获取根控制器
        let rootVC = UIApplication.shared.keyWindow?.rootViewController!
        let vc = rootVC?.childViewControllers[0]
        
        self.dismiss(animated: true, completion: nil)           // 返回上一级控制器
        vc?.present(qrcodeVC!, animated: true, completion: nil)  // motal展现
    }
    
    /// 键盘即将显示 (弹起)
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        /// 用户通知信息
        let userInfo = notification.userInfo!
        
        /// 键盘的动画持续时间
        let duration = userInfo["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        
        /// 键盘的尺寸
        let keyboardFrame = userInfo["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        
        UIView.animate(withDuration: duration) {     // 往上平移,键盘的高度
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
        }
    }
    
    /// 键盘即将隐藏 (收起)
    @objc fileprivate func keyboardWillHide() {
        InputTextField.resignFirstResponder()   // 辞去第一响应者 (收起键盘)
        self.bottomView.transform = .identity   // 恢复 (往下平移 键盘的高度)
    }
 
    
    /// 根据输入框文字的个数，设置ReminderLabel的内容，以及按钮的状态.
    @objc fileprivate func textFieldDidChange() {
       
        // 获取输入框的字符数
        switch (InputTextField.text!.characters.count) {
        case 0:
            reminderLabel.text = "输入车牌号, 获取解锁码"
        case 1...3:
            reminderLabel.text = "车牌号一般为4~8位的数字"
        default:
            reminderLabel.text = "温馨提示：若输错车牌号，将无法打开车锁"
        }
        
        // 如果输入的字符: 大于0个字符. 设置背景色,隐藏占位符
        if InputTextField.text!.characters.count > 0  {
            ImmediatelyCar.backgroundColor = ofoWholeColor
            customPlaceholderLabel.isHidden = true
            
        }else {
            ImmediatelyCar.backgroundColor = UIColor.lightGray
            customPlaceholderLabel.isHidden = false
        }
    }
    
}



// MARK: - UITextFieldDelegate 协议
extension InputCarLicenseController: UITextFieldDelegate {
    
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
        
/*
        if range.location < 11 {
            
            
            /// 当前文字
            let currentText = textField.text ?? ""
            
            /// 新的文字
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            switch newText.characters.count {
            case 0:
                ReminderLabel.text = "输入车牌号, 获取解锁码"
            case 1...3:
                ReminderLabel.text = "车牌号一般为4~8位的数字"
            default:
                ReminderLabel.text = "温馨提示: 若输错车牌号, 将无法打开车锁"
                
            }
            

            // 如果输入的字符: 大于0个字符. 设置背景色
            if newText.characters.count > 0  {
                 ImmediatelyCar.backgroundColor = ofoWholeColor
            } else {
                 ImmediatelyCar.backgroundColor = UIColor.lightGray
            }
         
            return true
            
        } else {
            return false
        }
*/
    }
    
}
