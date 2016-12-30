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
    case skChessViewTypeRed
    case skChessViewTypeBlack
}

protocol SKChessViewDelegate {
    func didSelect(_ target: SKChessView)
}

class SKChessView: UIView {
    
    fileprivate var type: SKChessViewType?
    var delegate: SKChessViewDelegate?
    var chessLabel: UILabel!
    var index = 0
    var chessType: SKChessViewType? {
        get {
            return type
        }
        set {
            type = newValue
            if newValue == SKChessViewType.skChessViewTypeBlack {
                layer.borderColor = UIColor.black.cgColor
                chessLabel.textColor = UIColor.black
            }
            else if newValue == SKChessViewType.skChessViewTypeRed {
                layer.borderColor = UIColor.red.cgColor
                chessLabel.textColor = UIColor.red
            }
        }
    }
    
    func select () {
        layer.borderColor = UIColor.yellow.cgColor
    }
    
    func unSelect () {
        chessType = type
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = frame.size.width / 2.0
        layer.borderWidth = 5.0
        
        chessLabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height))
        chessLabel.backgroundColor = UIColor.clear
        chessLabel.font = UIFont.boldSystemFont(ofSize: frame.size.width / 2.0)
        chessLabel.textAlignment = NSTextAlignment.center
        addSubview(chessLabel)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard delegate == nil else {
            delegate?.didSelect(self)
            return
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
