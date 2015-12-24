//
//  ViewController.swift
//  ChessChinese
//
//  Created by StevenKuo on 2015/6/23.
//  Copyright © 2015年 StevenKuo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SKChessViewDelegate, SKCoverChessViewDelegate, SKEmptyChessViewDelegate {

    private let chessManager = SKChessManager()
    private var startChess: SKChessView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let board = SKChessBoard(frame: CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height))
        view.addSubview(board)
        resetChessView()
    }
    
    func didOpen(index: Int) {
        chessManager.openedIndex.append(index)
    }
    
    func moveToIndex(index: Int) {
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

    func didSelect(target: SKChessView) {
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
        for (index, chess) in chessManager.chessScope.enumerate() {
            let row = Int(index / 8)
            let colum = index % 8
            guard chess != nil else {
                let emptyView = SKEmptyChessView(frame: CGRectMake(view.frame.size.width / 8.0 * CGFloat(colum) + (view.frame.size.width / 8.0 - chessSize) / 2.0, view.frame.size.height / 4.0 * CGFloat(row) + (view.frame.size.height / 4.0 - chessSize) / 2.0, chessSize, chessSize))
                emptyView.index = index
                emptyView.delegate = self
                view.addSubview(emptyView)
                continue
            }
            let chessView = SKChessView(frame: CGRectMake(view.frame.size.width / 8.0 * CGFloat(colum) + (view.frame.size.width / 8.0 - chessSize) / 2.0, view.frame.size.height / 4.0 * CGFloat(row) + (view.frame.size.height / 4.0 - chessSize) / 2.0, chessSize, chessSize))
            chessView.index = index
            chessView.delegate = self
            switch chess! {
            case "兵", "俥", "瑪", "炮", "帥", "仕", "相":
                chessView.chessType = SKChessViewType.SKChessViewTypeRed
            default :
                chessView.chessType = SKChessViewType.SKChessViewTypeBlack
                
            }
            chessView.chessLabel.text = chess
            view.addSubview(chessView)
            if chessManager.openedIndex.contains(index) {
                continue
            }
            let chessCoverView = SKCoverChessView(frame: CGRectMake(view.frame.size.width / 8.0 * CGFloat(colum) + (view.frame.size.width / 8.0 - chessSize) / 2.0, view.frame.size.height / 4.0 * CGFloat(row) + (view.frame.size.height / 4.0 - chessSize) / 2.0, chessSize, chessSize))
            chessCoverView.index = index
            chessCoverView.delegate = self
            view.addSubview(chessCoverView)
            
        }
    }


}

