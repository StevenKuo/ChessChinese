//
//  ViewController.swift
//  ChessChinese
//
//  Created by StevenKuo on 2015/6/23.
//  Copyright © 2015年 StevenKuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SKChessViewDelegate, SKCoverChessViewDelegate, SKEmptyChessViewDelegate {

    fileprivate let chessManager = SKChessManager()
    fileprivate var startChess: SKChessView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let board = SKChessBoard(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height))
        view.addSubview(board)
        resetChessView()
    }
    
    func didOpen(_ index: Int) {
        chessManager.openedIndex.append(index)
    }
    
    func moveToIndex(_ index: Int) {
        guard let _ = startChess else {
            return
        }
        if chessManager.permit(fristIndex: startChess!.index, secondIndex: index) {
            chessManager.move(from: startChess!.index, to: index)
            startChess!.unSelect()
            startChess = nil
            resetChessView()
        }
    }

    func didSelect(_ target: SKChessView) {
        guard startChess == nil else {
            if startChess!.chessType != target.chessType && chessManager.permit(fristIndex: startChess!.index, secondIndex: target.index){
                chessManager.updateChessScope(firstIndex: startChess!.index, secondIndex: target.index)
                startChess!.unSelect()
                startChess = nil
                resetChessView()
                return
            }
            startChess!.unSelect()
            startChess = nil
            return
        }
        startChess = target
        target.select()
    }
    
    func resetChessView () {

        for chessView in view.subviews {
            if chessView is SKChessView || chessView is SKCoverChessView{
                chessView.removeFromSuperview()
            }
        }
        let chessSize = view.frame.size.width / 8.0 < view.frame.height / 4.0 ? view.frame.size.width / 8.0 : view.frame.size.height / 4.0
        for (index, chess) in chessManager.chessScope.enumerated() {
            let row = Int(index / 8)
            let colum = index % 8
            guard chess != nil else {
                let emptyView = SKEmptyChessView(frame: CGRect(x: view.frame.size.width / 8.0 * CGFloat(colum) + (view.frame.size.width / 8.0 - chessSize) / 2.0, y: view.frame.size.height / 4.0 * CGFloat(row) + (view.frame.size.height / 4.0 - chessSize) / 2.0, width: chessSize, height: chessSize))
                emptyView.index = index
                emptyView.delegate = self
                view.addSubview(emptyView)
                continue
            }
            let chessView = SKChessView(frame: CGRect(x: view.frame.size.width / 8.0 * CGFloat(colum) + (view.frame.size.width / 8.0 - chessSize) / 2.0, y: view.frame.size.height / 4.0 * CGFloat(row) + (view.frame.size.height / 4.0 - chessSize) / 2.0, width: chessSize, height: chessSize))
            chessView.index = index
            chessView.delegate = self
            switch chess! {
            case "兵", "俥", "瑪", "炮", "帥", "仕", "相":
                chessView.chessType = SKChessViewType.skChessViewTypeRed
            default :
                chessView.chessType = SKChessViewType.skChessViewTypeBlack
                
            }
            chessView.chessLabel.text = chess
            view.addSubview(chessView)
            if chessManager.openedIndex.contains(index) {
                continue
            }
            let chessCoverView = SKCoverChessView(frame: CGRect(x: view.frame.size.width / 8.0 * CGFloat(colum) + (view.frame.size.width / 8.0 - chessSize) / 2.0, y: view.frame.size.height / 4.0 * CGFloat(row) + (view.frame.size.height / 4.0 - chessSize) / 2.0, width: chessSize, height: chessSize))
            chessCoverView.index = index
            chessCoverView.delegate = self
            view.addSubview(chessCoverView)
            
        }
    }


}

