//
//  MobileTextField.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/8.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class MobileTextField: UITextField {
    
    //保存上一次的文本内容
    private var previosText = ""
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.gray.cgColor)
        let orginPoint = CGPoint(x: self.bounds.origin.x, y: self.bounds.origin.y + self.frame.height - 1)
        context?.move(to: orginPoint)
        context?.addLine(to: CGPoint(x: orginPoint.x + bounds.width, y: orginPoint.y))
        context?.closePath()
        context?.strokePath()
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
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    //当输入文字时，动态设置文本框以344格式显示
    @objc private func textFieldDidChange() {
        //将文本框格式化显示
        formatToMobileNumber()
        
        if text!.count <= 11 {
            previosText = self.text!
        }

        if text!.count >= 11 {
            self.text = previosText
            //将文本框格式化显示
            formatToMobileNumber()
            return
        }
    }
    
    //给文本框设定344显示格式
    func formatToMobileNumber() {
        let length = self.text!.count
        let attributedString = NSMutableAttributedString(string: text!)
        if length > 3 {
            attributedString.addAttribute(NSAttributedString.Key.kern, value: 5, range: NSRange(location: 2,length: 1))
            if length > 7 {
                attributedString.addAttribute(NSAttributedString.Key.kern, value: 5, range: NSRange(location: 6,length: 1))
            }
            self.attributedText = attributedString
        }
    }
    
    //设置 复制、粘贴
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        }
        return true
    }
}
