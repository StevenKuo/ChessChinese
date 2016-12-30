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
    
    override func draw(_ rect: CGRect) {
        let verticalHeight: CGFloat = rect.size.height / 4.0
        let horizonWidth: CGFloat = rect.size.width / 8.0
        let context: CGContext = UIGraphicsGetCurrentContext()!
        for index in 1...3 {
            context.move(to: CGPoint(x: 0.0, y: verticalHeight * CGFloat(index)))
            context.addLine(to: CGPoint(x: rect.size.width, y: verticalHeight * CGFloat(index)))
        }
        for index in 1...7 {
            context.move(to: CGPoint(x: horizonWidth * CGFloat(index), y: 0.0))
            context.addLine(to: CGPoint(x: horizonWidth * CGFloat(index), y: rect.size.height))
        }
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
    }
}
