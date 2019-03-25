//
//  VerifyCodeView.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/8.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

@IBDesignable
class VerifyCodeView: UIView {
    
    /// 生成的验证码
    var verifyCode: String?
    private let veryfyLength = 4
    
    let strArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    
    var reachbility: Reachability!

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        //当验证码位数少于指定长度时，不生成验证码。
        guard let verifyCode = verifyCode else {
            return
        }
        
//        self.backgroundColor = MyColor.randomColor

        //获取每个字符需要的宽度
        let width = Int(self.bounds.width) / veryfyLength
        let height = Int(self.bounds.height)

        for (index, char) in verifyCode.enumerated() {
            
            let pX = CGFloat(index * width + self.randomNumber(number: width) / 2)
            let pY = CGFloat(self.randomNumber(number: height) / 2)
            //随机字体大小
            let fontSize = CGFloat(self.randomNumber(number: 10) + 15)
            let font = UIFont.systemFont(ofSize: fontSize)
            let text = NSString(string: "\(char)")
            text.draw(at: CGPoint(x: pX, y: pY), withAttributes: [NSAttributedString.Key.font: font])
        }
        
        //绘制干扰线
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        
        for _ in 0..<5 {
            //随机线条颜色
            context?.setStrokeColor(MyColor.randomColor.cgColor)
            
            var point = CGPoint(x: 0, y: 0)
            
            //随机起点
            point = CGPoint(x: CGFloat(self.randomNumber(number: Int(rect.size.width))), y: CGFloat(self.randomNumber(number: Int(rect.size.height))))
            context?.move(to: point)
            
            //随机终点
            point = CGPoint(x: CGFloat(self.randomNumber(number: Int(rect.size.width))), y: CGFloat(self.randomNumber(number: Int(rect.size.height))))
            context?.addLine(to: point)
            
            context?.strokePath()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    private func initSetup() {
        self.backgroundColor = MyColor.verifyCodeBg
    }
    
    //生成验证码
    func generateVerifyCode() {
        self.backgroundColor = MyColor.randomColor

        verifyCode = ""
        for _ in 0..<veryfyLength {
            let index = randomNumber(number: strArray.count)
            verifyCode!.append(strArray[index])
        }
        //重绘界面
        self.setNeedsDisplay()
    }
    
    //清除验证码
    func clearVerifyCode() {
        verifyCode = nil
        self.backgroundColor = MyColor.verifyCodeBg
        //重绘界面
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        let reachbility: Reachability!
        
        if reachbility.connection != .unavailable {
            self.generateVerifyCode()
        } else {
            SwiftNotice.showText("无法连接网络，请检查网络情况！", autoClear: true, autoClearTime: 1)
            self.clearVerifyCode()
        }
    }
    
    //获取 0 - number 之间的随机数
    private func randomNumber(number: Int) -> Int {
        return Int(arc4random()) % number
    }

}
