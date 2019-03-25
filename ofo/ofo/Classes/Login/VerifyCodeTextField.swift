//
//  VerifyCodeTextField.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/8.
//  Copyright © 2017年 LC. All rights reserved.
//


import UIKit

//@IBDesignable
class VerifyCodeTextField: UITextField {
    
    /// 结束编辑时，是否隐藏键盘
    var shouldHideKeyboardWhenEndEdit = false

    /// 是否输入完成
    private var isEndEditing = false
    
    /// 数字的位数
    private let numberBit = 4
    
    /// 每条下划线的宽度
    private var lineWidth: CGFloat!
    
    /// 线的间距
    private let lineSpace: CGFloat = 10
    
    /// 保存上一次的文本内容
    var previosText: String!
    
    /// 保存上一次的文本范围
    var previosRange: UITextRange!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.gray.cgColor)
//        let orginX = self.bounds.origin.x
        let orginY = self.bounds.height
        
        for index in 0 ..< numberBit {
            let startX = CGFloat(index) * (lineWidth + lineSpace)
            context?.move(to: CGPoint(x: startX, y: orginY))
            context?.addLine(to: CGPoint(x: startX + lineWidth, y: orginY))
        }
        context?.closePath()
        context?.strokePath()
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let halfLineWidth = lineWidth / 2
        return CGRect(x: halfLineWidth, y: 0, width: bounds.width - halfLineWidth + 5, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let halfLineWidth = lineWidth / 2
        return CGRect(x: halfLineWidth, y: 0, width: bounds.width - halfLineWidth + 5, height: bounds.height)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    //初始化相关设置
    private func initSetup() {
        self.keyboardType = .numberPad
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        lineWidth = (self.frame.width - (CGFloat(numberBit) * 10)) / CGFloat(numberBit)
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        
        isEndEditing = false
        
        if text!.count <= numberBit {
            previosText = self.text!
            formatToVerifyCode()
        }
        
        if text!.count >= numberBit {
            self.text = previosText

            //将文本框格式化显示
            formatToVerifyCode()
            
            isEndEditing = true
            
            //输入达到了位数，结束编辑
            if shouldHideKeyboardWhenEndEdit {
                self.resignFirstResponder()
            }
            return
        }
    }
    
    //给文本框字符设定超宽间距
    func formatToVerifyCode() {
        let attributedString = NSMutableAttributedString(string: text!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: lineWidth, range: NSRange(location: 0,length: (text!.count <= numberBit - 1)  ? text!.count : (numberBit - 1)))
        
        self.attributedText = attributedString
    }

    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }

}
