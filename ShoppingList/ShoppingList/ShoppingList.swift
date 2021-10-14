//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/10/14.
//

import Foundation
import UIKit
enum Bookmark: Int {
    case off,on
//    switch self {
//    case .checkStar:
//        0
//    case .noneCheck:
//        1
//    }
}
enum OrderCheck: Int {
    case none,check
}

struct ShoppingList{
    var memo: String
    var bookmark: Bookmark
    var orderCheck: OrderCheck
}
