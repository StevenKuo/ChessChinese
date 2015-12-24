//
//  SKChessView.swift
//  ChessChinese
//
//  Created by StevenKuo on 2015/6/23.
//  Copyright © 2015年 StevenKuo. All rights reserved.
//

import Foundation
import UIKit

enum SKChessViewType {
    case SKChessViewTypeRed
    case SKChessViewTypeBlack
}

protocol SKChessViewDelegate {
    func didSelect(target: SKChessView)
}

class SKChessView: UIView {
    
    private var type: SKChessViewType?
    var delegate: SKChessViewDelegate?
    var chessLabel: UILabel!
    var index = 0
    var chessType: SKChessViewType? {
        get {
            return type
        }
        set {
            type = newValue
            if newValue == SKChessViewType.SKChessViewTypeBlack {
                layer.borderColor = UIColor.blackColor().CGColor
                chessLabel.textColor = UIColor.blackColor()
            }
            else if newValue == SKChessViewType.SKChessViewTypeRed {
                layer.borderColor = UIColor.redColor().CGColor
                chessLabel.textColor = UIColor.redColor()
            }
        }
    }
    
    func select () {
        layer.borderColor = UIColor.yellowColor().CGColor
    }
    
    func unSelect () {
        chessType = type
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        layer.cornerRadius = frame.size.width / 2.0
        layer.borderWidth = 5.0
        
        chessLabel = UILabel(frame: CGRectMake(0.0, 0.0, frame.size.width, frame.size.height))
        chessLabel.backgroundColor = UIColor.clearColor()
        chessLabel.font = UIFont.boldSystemFontOfSize(frame.size.width / 2.0)
        chessLabel.textAlignment = NSTextAlignment.Center
        addSubview(chessLabel)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        guard delegate == nil else {
            delegate?.didSelect(self)
            return
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}