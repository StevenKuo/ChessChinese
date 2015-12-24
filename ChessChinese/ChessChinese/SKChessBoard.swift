//
//  SKChessBoard.swift
//  ChessChinese
//
//  Created by StevenKuo on 2015/6/23.
//  Copyright © 2015年 StevenKuo. All rights reserved.
//

import Foundation
import UIKit

class SKChessBoard: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.79, green: 0.61, blue: 0.14, alpha: 1.0)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let verticalHeight: CGFloat = rect.size.height / 4.0
        let horizonWidth: CGFloat = rect.size.width / 8.0
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        for index in 1...3 {
            CGContextMoveToPoint(context, 0.0, verticalHeight * CGFloat(index))
            CGContextAddLineToPoint(context, rect.size.width, verticalHeight * CGFloat(index))
        }
        for index in 1...7 {
            CGContextMoveToPoint(context, horizonWidth * CGFloat(index), 0.0)
            CGContextAddLineToPoint(context, horizonWidth * CGFloat(index), rect.size.height)
        }
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextStrokePath(context)
    }
}