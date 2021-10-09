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
    @IBOutlet var statusImage: UIImageView!
    var sumOfwater: Int = 0
    var userWeight: Int = 0
    let imageArray: [String] = ["1-1","1-2","1-3","1-4","1-5","1-6","1-7","1-8","1-9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sumOfwater = UserDefaults.standard.integer(forKey: "sumOfwater")
        userWeight = UserDefaults.standard.integer(forKey: "userWeight")
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
    //물 하루 권장량 계산
    func calculate(){
        var recommendedAmount: Int
        var target: Double
        //예외처리 - 저장된 값이 없을 시 권장량 2000
        if userWeight == 0 {
            recommendedAmount = 2000
        }
        //권장량 계산
        else{
            recommendedAmount = userWeight * 30
        }
        //예외처리 - 0을 x로 나누는 것이 불가능 함 따라서 저장된 값이 없을 시 목표치 0
        if sumOfwater == 0 {
            target = 0
        }
        //현재 목표치 계산
        else{
            target = Double(sumOfwater)/Double(recommendedAmount)*100
            target = round(target*100)/100
        }
        //현재 달성한 목표치 label text
        if target >= 100 {
            bottomLabel.text = " 목표 완료!! \( target )%"
        }
        else{
            bottomLabel.text = " 목표의 \( target )%"
        }
        //사용자 편의성을 위해 단위(ml) 추가
        middleLabel.text = "\(sumOfwater)ml"
        //상태이미지 변경
        imageChange(target: target)
        
    }
    //현재 목표치(percent)로 상태 이미지 변경
    func imageChange(target: Double){
        
        if target < 15 {
            statusImage.image = UIImage(named: imageArray[0])
        }
        else if 15 <= target && target < 30 {
            statusImage.image = UIImage(named: imageArray[1])
        }
        else if 30 <= target && target < 40 {
            statusImage.image = UIImage(named: imageArray[2])
        }
        else if 40 <= target && target < 50 {
            statusImage.image = UIImage(named: imageArray[3])
        }
        else if 50 <= target && target < 60 {
            statusImage.image = UIImage(named: imageArray[4])
        }
        else if 60 <= target && target < 70 {
            statusImage.image = UIImage(named: imageArray[5])
        }
        else if 70 <= target && target < 85 {
            statusImage.image = UIImage(named: imageArray[6])
        }
        else if 85 <= target && target < 100 {
            statusImage.image = UIImage(named: imageArray[7])
        }
        else{
            statusImage.image = UIImage(named: imageArray[8])
        }
    }
    
    //물 마시기 버튼 액션
    @IBAction func drinkBtnAction(_ sender: UIButton) {
        if var text: String = literText.text{
            //문자열에 'ml' 가 있다면 Int형 변환을 하기 위해 삭제
            text = text.replacingOccurrences(of: "ml", with: "")
            //예외처리 - 숫자가 아닌 문자열은 0으로 치환
            let textInt = Int(text) ?? 0
            //이전 총 먹은 물의 양에 합산하여 저장
            UserDefaults.standard.set(textInt + sumOfwater, forKey: "sumOfwater")
            //저장 값 새로 읽어옴
            sumOfwater = UserDefaults.standard.integer(forKey: "sumOfwater")
            //새로 목표치 계산
            calculate()
            literText.text = "\(textInt)ml"
        }
    }
    
    //새로 고침 버튼 액션
    @IBAction func refreshBtnAction(_ sender: UIBarButtonItem) {
        //기존 데이터 삭제
        UserDefaults.standard.removeObject(forKey: "sumOfwater")
        sumOfwater = UserDefaults.standard.integer(forKey: "sumOfwater")
        //먹은 물의 총 합 0 으로 새로 계산
        calculate()
    }
    
    //텝제스쳐 시 키보드 내림
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //return(done)
    @IBAction func textFieldExit(_ sender: HoshiTextField) {
    }
}
