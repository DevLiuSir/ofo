//
//  String+Extension.swift
//  ofo
//
//  Created by LiuChuan on 2017/7/23.
//  Copyright © 2017年 LC. All rights reserved.
//

import Foundation


extension String {
    
    /// 判断字符串是否是手机号
    var isMobileNumber: Bool  {
        let string = self.withoutSpace()
        let mobile = "^1[34578]\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", mobile)
        return predicate.evaluate(with: string)
    }
    
    ///给手机号设置中间四位显示****
    func withStar() -> String {
        var string = self
        let startIndex = self.index(string.startIndex, offsetBy: 3)
        let endIndex = self.index(string.startIndex, offsetBy: 7)
//        string.replaceSubrange(Range<String.Index>(startIndex..<endIndex), with: "****")
        string.replaceSubrange(startIndex..<endIndex, with: "****")
        return string
    }
    
    ///给手机号设置344格式 eg.188 8888 8888
    func withSpace() -> String {
        var string = self
        string.insert(" ", at: self.index(string.startIndex, offsetBy: 7))
        string.insert(" ", at: self.index(string.startIndex, offsetBy: 3))
        return string
    }
    
    ///去掉字符串中的空格
    func withoutSpace() -> String {
        let string = self
        return string.replacingOccurrences(of: " ", with: "")
    }
    

    /// 检测字符串是否是合法用户名
    ///
    /// 仅支持中文、英文大小写、数字、"_"、减号及其组合
    /// - Parameters:
    ///   - min: 最小字节数，默认是4
    ///   - max: 最大字节数，默认是16
    ///   - isUserName: 是否检测字符内容
    /// - Returns: 返回匹配结果
  
    func checkStringIsUserName(min: Int = 4, max: Int = 16) -> Bool {
        //记录字节数
        var length = 0
        
        //判断双字节字符数量，双字节字符算2个字节，所以要*2。
        var pattern = "[\u{4E00}-\u{9FA5}]"
        var matcher = MyRegex(pattern: pattern)
        length += (matcher.match(input: self))*2
        
        //判断单字节字符数量
        pattern = "[a-zA-Z0-9_-]"
        matcher = MyRegex(pattern: pattern)
        length += matcher.match(input: self)
        
        //当长度超过4字符，且不超过16字符，再匹配字符是否合法。
        if (length >= min && length <= max) {
            pattern = "^[\u{4E00}-\u{9FA5}A-Za-z0-9_-]+$"
            matcher = MyRegex(pattern: pattern)
            return matcher.match(input: self)
        } else {
            return false
        }

    }
    
    ///给String增加下标索引功能
    subscript(index: Int) -> String {
        get {
            return String(self[self.index(self.startIndex, offsetBy: index)])
        }
        set {
            let temp = self
            self = ""
            for(idx, item) in temp.enumerated() {
                if idx == index {
                    self += "\(newValue)"
                } else {
                    self += "\(item)"
                }
            }
        }
    }
}
