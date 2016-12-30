//
//  SKEmptyChessView.swift
//  ChessChinese
//
//  Created by StevenKuo on 2015/6/24.
//  Copyright © 2015年 StevenKuo. All rights reserved.
//

import Foundation
import UIKit

protocol SKEmptyChessViewDelegate {
    func moveToIndex(_ index: Int)
}

class SKEmptyChessView: UIView {
    var index = 0
    var delegate: SKEmptyChessViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let _ = delegate else {
            return
        }
        delegate! .moveToIndex(index)
    }
}
