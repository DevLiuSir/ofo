//
//  MyRegex.swift
//  ofo
//
//  Created by Hailiang on 2017/7/22.
//  Copyright © 2017年 Hailiang. All rights reserved.
//

import Foundation
/// 正则匹配工具类
struct MyRegex {
    let regex: NSRegularExpression?
    
    init(pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    //匹配是否成功
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
            return matches.count > 0
        } else {
            return false
        }
    }
    
    //匹配字符个数
    func match(input: String) -> Int {
        if let matches = regex?.matches(in: input, options: [], range: NSRange(location: 0, length: input.count)) {
            return matches.count
        } else {
            return 0
        }
    }
}
