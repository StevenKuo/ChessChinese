//
//  SKCoverChessView.swift
//  ChessChinese
//
//  Created by StevenKuo on 2015/6/23.
//  Copyright © 2015年 StevenKuo. All rights reserved.
//

import Foundation
import UIKit

protocol SKCoverChessViewDelegate {
    func didOpen(index: Int)
}

class SKCoverChessView: UIView {
    var index = 0
    var delegate: SKCoverChessViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.18, green: 0.56, blue: 0.13, alpha: 1.0)
        layer.cornerRadius = frame.size.width / 2.0
        layer.borderWidth = 5.0
        layer.borderColor = UIColor.blackColor().CGColor
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        removeFromSuperview()
        guard let _ = delegate else {
            return
        }
        delegate!.didOpen(index)
    }
}