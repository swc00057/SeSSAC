//
//  BoxOfficeModel.swift
//  DailyBoxOffice
//
//  Created by 신동원 on 2021/11/03.
//

import Foundation
import RealmSwift

class BoxOfficeModel: Object {
    @Persisted var searchDate: String
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var dailyBoxOffice = List<DailyBoxOfficeModel>()
    
    convenience init(searchDate: String,dailyBoxOffice: List<DailyBoxOfficeModel>){
        self.init()
        self.searchDate = searchDate
        self.dailyBoxOffice = dailyBoxOffice
    }
}

class DailyBoxOfficeModel: Object {
    @Persisted var title: String
    @Persisted var rank: String
    @Persisted var releaseDate: String
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, rank: String, releaseDate: String){
        self.init()
        self.title = title
        self.rank = rank
        self.releaseDate = releaseDate
        
    }
}
