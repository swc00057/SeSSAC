//
//  SignUpViewController.swift
//  Shinflix
//
//  Created by 신동원 on 2021/10/11.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var signUpStackView: UIStackView!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var nickNameText: UITextField!
    @IBOutlet var placeText: UITextField!
    @IBOutlet var recommandCodeText: UITextField!
    @IBOutlet var signUpBtn: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    //추가 정보
    @IBOutlet var furtherInfoLabel: UILabel!
    @IBOutlet var furtherInfoSwitch: UISwitch!
    @IBOutlet var furtherInfoStackView: UIStackView!
    @IBOutlet var ageText: UITextField!
    @IBOutlet var addressText: UITextField!
    @IBOutlet var etcText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        // Do any additional setup after loading the view.
    }
    func setup(){
        //스택뷰,배경색,타이틀 설정
        signUpStackView.spacing = 15
        mainView.backgroundColor = .black
        titleLabel.text = "SHINFLIX"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.init(named: "SignUpTitle")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        
        //텍스트필드 설정
        emailText.signUpSetup(text: "이메일 주소 또는 전화번호")
        passwordText.signUpSetup(text: "비밀번호")
        passwordText.isSecureTextEntry = true
        nickNameText.signUpSetup(text: "닉네임")
        placeText.signUpSetup(text: "위치")
        recommandCodeText.signUpSetup(text: "추천 코드 입력")
        
        //회원가입 버튼 설정
        signUpBtn.backgroundColor = .white
        signUpBtn.setTitle("회원가입", for: .normal)
        signUpBtn.setTitleColor(.black, for: .normal)
        
        //추가 정보 설정
        furtherInfoLabel.text = "추가 정보 입력"
        furtherInfoLabel.textColor = .white
        furtherInfoSwitch.onTintColor = UIColor(named: "SignUpTitle")
        furtherInfoSwitch.setOn(false, animated: true)
        furtherInfoStackView.isHidden = true
        furtherInfoStackView.spacing = 15
        ageText.signUpSetup(text: "나이")
        addressText.signUpSetup(text: "주소")
        etcText.signUpSetup(text: "기타사항")
        
    }
    
    //스위치 액션
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            furtherInfoStackView.isHidden = false
        }
        else{
            furtherInfoStackView.isHidden = true
        }
    }
    
    //회원가입 버튼 액션
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        print("\(emailText.text ?? "")\n\(passwordText.text ?? "")\n\(nickNameText.text ?? ""   )\n\(placeText.text ?? "")\n\(recommandCodeText.text ?? "")\n")
        if furtherInfoSwitch.isOn {
            print("\(ageText.text ?? "")\n\(addressText.text ?? "")\n\(etcText.text ?? "")")
        }
    }
    //탭제스쳐 키보드 내리기
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

//텍스트 필드 설정
extension UITextField {
    func signUpSetup(text: String){
        self.backgroundColor = UIColor.gray
        self.textColor = UIColor.white
        self.textAlignment = NSTextAlignment.center
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.white])
    }
}
