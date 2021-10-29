//
//  LotteryAPIManager.swift
//  Lottery
//
//  Created by 신동원 on 2021/10/29.
//

import Foundation
import Alamofire
import SwiftyJSON

class LotteryAPIManager {
    
    static let shared = LotteryAPIManager()
    
    func fetchLottery(_ text: String,_ result: @escaping(Int, JSON) -> () ){
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let httpCode = response.response?.statusCode else{ return }
                switch httpCode {
                case 200:
                    result(httpCode,json)
                    print("HTTP 200 OK")
                case 400:
                    print("Bad request")
                    result(httpCode,json)
                default:
                    print("fail")
                }
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
