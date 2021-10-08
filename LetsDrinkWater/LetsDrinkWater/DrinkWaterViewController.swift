//
//  DrinkWaterViewController.swift
//  LetsDrinkWater
//
//  Created by 신동원 on 2021/10/08.
//

import UIKit
import TextFieldEffects

class DrinkWaterViewController: UIViewController {
    @IBOutlet var drinkBtn: UIButton!
    
    @IBOutlet var labelView: UIView!
    @IBOutlet var middleLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var literText: UITextField!
    var sumOfwater: Int = 0
    var userWeight: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sumOfwater = UserDefaults.standard.integer(forKey: "sumOfwater")
        userWeight = UserDefaults.standard.integer(forKey: "weight")
        calculate()
    }
    
    func setup(){
        //배경색
        self.view.backgroundColor = UIColor.init(named: "bgcolor")
        labelView.backgroundColor = .clear
        drinkBtn.backgroundColor = .systemYellow
        literText.backgroundColor = .clear
        
        //먹은 물의 양을 입력하는 텍스트필드
        literText.borderStyle = .none
        literText.textColor = .white
        literText.textAlignment = .center
        literText.font = UIFont.boldSystemFont(ofSize: 50)
        
        //첫번째 라벨
        topLabel.text = "잘하셨어요!\r오늘 마신 양은"
        topLabel.numberOfLines = 2
        topLabel.textColor = .white
        topLabel.font = UIFont.systemFont(ofSize: 23)
        
        //두번째 라벨
        middleLabel.textColor = .white
        middleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        //세번째 라벨
        bottomLabel.textColor = .white
        bottomLabel.font = UIFont.systemFont(ofSize: 15)
        
    }
    func calculate(){
        var recommendedAmount: Int
        var target: Double
        if userWeight == 0 {
            recommendedAmount = 2000
        }
        else{
            recommendedAmount = userWeight * 30
        }
        if sumOfwater == 0 {
            target = 0
        }
        else{
            target = Double(sumOfwater)/Double(recommendedAmount)*100
            target = round(target*100)/100
        }
        if target >= 100 {
            bottomLabel.text = " 목표 완료!! \( target )%"
        }
        else{
            bottomLabel.text = " 목표의 \( target )%"
        }
        middleLabel.text = "\(sumOfwater)ml"
        
    }
    

    @IBAction func drinkBtnAction(_ sender: UIButton) {
        var textInt: Int
        if var text: String = literText.text{
            text = text.replacingOccurrences(of: "ml", with: "")
            textInt = Int(text) ?? 0
            UserDefaults.standard.set(textInt + sumOfwater, forKey: "sumOfwater")
            sumOfwater = UserDefaults.standard.integer(forKey: "sumOfwater")
            calculate()
            literText.text = "\(textInt)ml"
        }
    }
    
    @IBAction func refreshBtnAction(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "sumOfwater")
        sumOfwater = UserDefaults.standard.integer(forKey: "sumOfwater")
        calculate()
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}
