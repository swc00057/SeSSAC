//
//  UserSetViewController.swift
//  LetsDrinkWater
//
//  Created by 신동원 on 2021/10/08.
//

import UIKit
import TextFieldEffects

class UserSetViewController: UIViewController {

    
    @IBOutlet var nickTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var weightTextField: HoshiTextField!
    @IBOutlet var userInfoSaveBtn: UIBarButtonItem!
    @IBOutlet var userNavibar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        nickTextField.placeholder = "닉네임을 입력해주세요"
        weightTextField.placeholder = "키cm을 설정해주세요"
        heightTextField.placeholder = "몸무게(kg)를 설정해주세요"
        userInfoSaveBtn.title = "저장"
        userNavibar.title = "사용자 설정"
        self.view.backgroundColor = UIColor.init(named: "bgcolor")
        self.navigationController?.navigationBar.tintColor = .white
        
        readUserInfo()
        

        // Do any additional setup after loading the view.
    }
    //사용자 정보 불러오기
    func readUserInfo(){
        
        nickTextField.text = UserDefaults.standard.string(forKey: "userNickname")
        weightTextField.text = UserDefaults.standard.string(forKey: "userWeight")
        heightTextField.text = UserDefaults.standard.string(forKey: "userHeight")
    }
    //사용자 정보 저장
    func writeUserInfo(){
        UserDefaults.standard.set(nickTextField.text, forKey: "userNickname")
        
        //몸무게, 키 Int형으로 저장
        if let text: Int = Int(weightTextField.text ?? ""){
            UserDefaults.standard.set(text, forKey: "userWeight")
        }
        if let text: Int = Int(heightTextField.text ?? ""){
            UserDefaults.standard.set(text, forKey: "userHeight")
        }
        
    }
    //저장 버튼 액션
    @IBAction func UserInfoSave(_ sender: UIBarButtonItem) {
        
        writeUserInfo()
        //저장 알림창
        let alert = UIAlertController(title: "저장되었습니다", message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: false, completion: nil)
    }
    //탭제스쳐 시 키보드 내림
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    //return(done)
    @IBAction func textFieldExit(_ sender: HoshiTextField) {
    }
    
}
