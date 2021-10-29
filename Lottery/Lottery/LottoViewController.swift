//
//  LottoViewController.swift
//  Lottery
//
//  Created by 신동원 on 2021/10/29.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    @IBOutlet weak var plusLabel: UILabel!
    @IBOutlet weak var bonusDrwLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var drwLabel: [UILabel]!
    @IBOutlet var timesLabel: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //회차 라벨
        self.timesLabel[0].text = "913회"
        self.timesLabel[0].font = .boldSystemFont(ofSize: 20)
        //self.timesLabel[0].textColor = .yellow
        self.timesLabel[1].text = "당첨결과"
        self.timesLabel[1].font = .boldSystemFont(ofSize: 20)
        
        fetchData()

        // Do any additional setup after loading the view.
    }
    func fetchData() {
        LotteryAPIManager.shared.fetchLottery("986") { httpCode, json in
            switch httpCode {
            case 200:
                //당첨 번호 라벨
                self.drwLabel.enumerated().forEach {
                    $1.text = json["drwtNo\($0 + 1)"].stringValue
                    $1.lottoBall()
                }
                //당첨 번호(보너스 및 + 기호) 라벨
                self.bonusDrwLabel.text = json["bnusNo"].stringValue
                self.bonusDrwLabel.lottoBall()
                self.plusLabel.lottoBall()
                
            default:
                print("fail")
            }
        }
    }

}
