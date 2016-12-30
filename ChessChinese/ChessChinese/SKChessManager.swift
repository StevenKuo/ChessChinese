//
//  SKChessManager.swift
//  ChessChinese
//
//  Created by StevenKuo on 2015/6/23.
//  Copyright © 2015年 StevenKuo. All rights reserved.
//

import Foundation

class SKChessManager {
    fileprivate(set) var chessScope = [String?](repeating: nil, count: 32)
    fileprivate var beatRule = (bin: ["將", "帥", "兵", "卒"], g: ["兵", "卒", "馬", "瑪", "炮", "包", "車", "俥"], ma: ["兵", "卒", "馬", "瑪", "炮", "包",], pao: ["兵", "俥", "瑪", "炮", "帥", "仕", "相", "卒", "車", "馬", "包", "將", "士", "象"], shawn: ["兵", "卒", "馬", "瑪", "炮", "包", "車", "俥", "相", "象"], shi: ["兵", "俥", "瑪", "炮", "仕", "相", "卒", "車", "馬", "包", "士", "象"], handsome: ["俥", "瑪", "炮", "帥", "仕", "相", "車", "馬", "包", "將", "士", "象"])
    var openedIndex = [Int]()
    init () {
        _initChessScope()
    }
    fileprivate func _initChessScope () {
        chessScope.removeAll()
        
        var chessSet = ["兵", "兵", "兵", "兵", "兵", "俥", "俥", "瑪", "瑪", "炮", "炮", "帥", "仕", "仕", "相", "相","卒", "卒", "卒", "卒", "卒", "車", "車", "馬", "馬", "包", "包", "將", "士", "士", "象", "象"]
        while (chessSet.count > 0) {
            let randomNum = Int(arc4random_uniform(UInt32(chessSet.count)))
            let randomIndex = chessSet.startIndex.advanced(by: randomNum);
            chessScope.append(chessSet[randomIndex])
            chessSet.remove(at: randomIndex)
        }
    }
    func updateChessScope (firstIndex from: Int, secondIndex to: Int) {
        let attack = chessScope[from]!
        let target = chessScope[to]!
        var rule: [String]? = nil
        switch attack {
        case "兵", "卒":
            rule = beatRule.bin
        case "俥", "車":
            rule = beatRule.g
        case "瑪", "馬":
            rule = beatRule.ma
        case "炮", "包":
            rule = beatRule.pao
        case "象", "相":
            rule = beatRule.shawn
        case "仕", "士":
            rule = beatRule.shi
        case "將", "帥":
            rule = beatRule.handsome
        default:
            print("error")
        }
        if rule!.contains(target) {
            print("\(attack) eat \(target)")
            chessScope[from] = nil
            chessScope[to] = attack
        }
        
    }
    
    func move (from firstIndex: Int, to secondIndex: Int) {
        let availableIndex = (top: firstIndex - 8, bottom: firstIndex + 8, left: firstIndex - 1, right: firstIndex + 1)
        if availableIndex.top == secondIndex || availableIndex.bottom == secondIndex || availableIndex.left == secondIndex || availableIndex.right == secondIndex {
            let temp = chessScope[firstIndex]
            chessScope[firstIndex] = nil
            chessScope[secondIndex] = temp
        }
    }
    
    func permit (fristIndex from: Int, secondIndex to: Int) -> Bool {
        let availableIndex = (top: from - 8, bottom: from + 8, left: from - 1, right: from + 1)
        if availableIndex.top == to || availableIndex.bottom == to || availableIndex.left == to || availableIndex.right == to {
            return true
        }
        if chessScope[from] == "炮" || chessScope[from] == "包" {
            return powLogic(fristIndex: from, secondIndex: to)
        }
        return false
    }
    func powLogic (fristIndex from: Int, secondIndex to: Int) -> Bool{
        var topIndexList = [Int]()
        var leftIndexList = [Int]()
        var rightIndexList = [Int]()
        var bottomIndexList = [Int]()
        
        let indexInRow = from % 8
        
        var initIndex = from
        while initIndex - 8 >= 0 {
            topIndexList.append(initIndex - 8)
            initIndex -= 8
        }
        initIndex = from
        while initIndex + 8 <= chessScope.count {
            bottomIndexList.append(initIndex + 8)
            initIndex += 8
        }
        
        initIndex = from
        while initIndex - 1 >= from - indexInRow {
            leftIndexList.append(initIndex - 1)
            initIndex -= 1
        }
        
        initIndex = from
        while initIndex + 1 <= from + (8 - (indexInRow + 1)) {
            rightIndexList.append(initIndex + 1)
            initIndex += 1
        }
        
        if topIndexList.contains(to) {
            let temp = topIndexList
            for index in temp {
                if index < to {
                    topIndexList.remove(at: topIndexList.index(of: index)!)
                }
            }
            var findchess = false
            for index in topIndexList {
                if index == to {
                    continue
                }
                if chessScope[index] != nil {
                    if findchess {
                        return false
                    }
                    findchess = true
                }
            }
            return true
        }
        if bottomIndexList.contains(to) {
            let temp = bottomIndexList
            for index in temp {
                if index > to {
                    bottomIndexList.remove(at: bottomIndexList.index(of: index)!)
                }
            }
            var findchess = false
            for index in bottomIndexList {
                if index == to {
                    continue
                }
                if chessScope[index] != nil {
                    if findchess {
                        return false
                    }
                    findchess = true
                }
            }
            return true
        }
        if leftIndexList.contains(to) {
            let temp = leftIndexList
            for index in temp {
                if index < to {
                    leftIndexList.remove(at: leftIndexList.index(of: index)!)
                }
            }
            var findchess = false
            for index in leftIndexList {
                if index == to {
                    continue
                }
                if chessScope[index] != nil {
                    if findchess {
                        return false
                    }
                    findchess = true
                }
            }
            return true
        }
        if rightIndexList.contains(to) {
            let temp = rightIndexList
            for index in temp {
                if index > to {
                    rightIndexList.remove(at: rightIndexList.index(of: index)!)
                }
            }
            var findchess = false
            for index in rightIndexList {
                if index == to {
                    continue
                }
                if chessScope[index] != nil {
                    if findchess {
                        return false
                    }
                    findchess = true
                }
            }
            return true
        }
        
        return false
    }
    
    
}
