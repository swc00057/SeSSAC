//
//  LedBoardViewController.swift
//  LEDBoard
//
//  Created by 신동원 on 2021/10/05.
//

import UIKit

class LedBoardViewController: UIViewController {

    @IBOutlet var colorBtn: UIButton!
    @IBOutlet var myTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var sendBtn: UIButton!
    @IBOutlet var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    //보내기 버튼 액션
    @IBAction func sendBtnAction(_ sender: UIButton) {
        resultLabel.text = myTextField.text
        self.view.endEditing(true)
    }
    //색 변환 버튼 액션
    @IBAction func colorBtnAction(_ sender: UIButton) {
        randomColor()
    }
    //UI 설정
    func setup(){
        sendBtn.layer.cornerRadius = 10
        colorBtn.layer.cornerRadius = 10
        myTextField.layer.cornerRadius = 10
        myTextField.placeholder = "텍스트를 입력해주세요"
        resultLabel.textColor = UIColor.white
        resultLabel.font = .systemFont(ofSize: 130)
        resultLabel.textAlignment = .center
        resultLabel.text = ""
    }
    //RGB 랜덤값 생성
    func randomColor(){
        let red : CGFloat = CGFloat.random(in: 0.5...1)
        let blue : CGFloat = CGFloat.random(in: 0.5...1)
        let green : CGFloat = CGFloat.random(in: 0.5...1)
        
        resultLabel.textColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    //탭제스쳐 구현 키보드내려가기 & 상단뷰 hidden 토글
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        if topView.isHidden == true {
            topView.isHidden = false
        }
        else{
            topView.isHidden = true
        }
    }
    //DidEndOnExit 설정으로 return -> done으로 변경
    @IBAction func returnToDone(_ sender: UITextField) {
        //myTextField.returnKeyType = .done
        resultLabel.text = myTextField.text
    }
}
