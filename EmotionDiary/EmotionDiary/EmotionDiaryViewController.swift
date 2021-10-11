//
//  EmotionDiaryViewController.swift
//  EmotionDiary
//
//  Created by 신동원 on 2021/10/12.
//

import UIKit

class EmotionDiaryViewController: UIViewController {

    @IBOutlet var image1: UIImageView!
    @IBOutlet var bgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainStackView: UIStackView!
    var intArray: [Int] = []
    let labelArray: [String] = ["행복해","사랑해","좋아해","당황해","속상해","우울해","심심해","귀찮아","눈물나"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //배경 이미지 및 타이틀
        bgView.image = UIImage(named: "background")
        bgView.contentMode = .scaleAspectFill
        titleLabel.text = "감정 다이어리"
        titleLabel.textAlignment = .center
        //데이터 표현 시작
        setupImageAndLabel()
        
        // Do any additional setup after loading the view.
    }
    //현재 데이터 저장
    func saveData(){
        var i: Int = 0
        for k in labelArray{
            UserDefaults.standard.set(intArray[i], forKey: k)
            i+=1
        }
        
    }
    //저장된 데이터 불러오기
    func loadData(){
        for k in labelArray{
            intArray.append(UserDefaults.standard.integer(forKey: k))
        }
        
    }
    //각 이미지 클릭 시 실행 하는 함수 그림마다 고유의 tag가 있음
    @objc func imageClicked(_ sender: UITapGestureRecognizer) {
        
        let tag = sender.view!.tag
        print(tag)
        //클릭한 이미지에 대응하는 배열의 값 1증가
        intArray[tag] = intArray[tag] + 1
        //데이터 저장
        saveData()
        //데이터 표현
        setupImageAndLabel()
        
        
    }
    func setupImageAndLabel(){
        //데이터 불러오기
        loadData()
        var i: Int = 0
        //스택뷰의 서브뷰 -> 서브뷰 순으로 이미지뷰와 라벨을 찾아 데이터 및 UI설정
        for v in mainStackView.arrangedSubviews{
            for subview in v.subviews{
                let imageView: UIImageView = subview.subviews[0] as! UIImageView
                let label: UILabel = subview.subviews[1] as! UILabel
                imageView.tag = i
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.imageClicked)))
                label.text = "\(labelArray[i]) \(intArray[i])"
                label.textAlignment = .center
                i+=1
            }
            
        }
    }
    


}
