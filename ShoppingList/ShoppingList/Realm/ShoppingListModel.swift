//
//  ShoppingListModel.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/11/02.
//

import Foundation
import RealmSwift



class ShoppingListModel: Object {
    
    @Persisted var memo: String
    @Persisted var bookmark: Bool
    @Persisted var orderCheck: Bool
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(memo: String) {
        
        self.init()
        self.memo = memo
        self.bookmark = false
        self.orderCheck = false
        
    }
}
