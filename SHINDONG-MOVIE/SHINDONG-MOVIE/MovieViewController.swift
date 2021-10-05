//
//  MovieViewController.swift
//  SHINDONG-MOVIE
//
//  Created by 신동원 on 2021/10/04.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet var playbtn: UIButton!

    @IBOutlet var previewBtn1: UIImageView!
    @IBOutlet var previewBtn2: UIImageView!
    @IBOutlet var previewBtn3: UIImageView!
    @IBOutlet var poster: UIImageView!
    let posterArray: [String] = ["어벤져스엔드게임","아바타","겨울왕국2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //미리보기 이미지 배열에 추가
        let previewBtnArray: [UIImageView] = [previewBtn1,previewBtn2,previewBtn3]
        //start 함수
        start(previewBtnArray: previewBtnArray)
        
    }
    //이미지 태그별 클릭시 포스터변경
    @objc func previewImageClicked(_ sender: UITapGestureRecognizer) {
        let tag: Int = sender.view!.tag
        if tag == 1000 {
            poster.image = UIImage(named:posterArray[0])
        }
        else if tag == 1001 {
            poster.image = UIImage(named: posterArray[1])
        }
        else if tag == 1002 {
            poster.image = UIImage(named: posterArray[2])
        }
    }
    
    func start(previewBtnArray: [UIImageView]) {
        //플레이버튼 모서리 둥글게 변경
        playbtn.layer.cornerRadius = 10
        
        //배열에 포함된 3개의 이미지뷰에 제스쳐(클릭) 이벤트 추가 및 이미지 원형으로 변경
        for i in 0...previewBtnArray.count - 1 {
            previewBtnArray[i].layer.cornerRadius = previewBtnArray[i].frame.height/2
            previewBtnArray[i].tag = 1000 + i
            previewBtnArray[i].isUserInteractionEnabled = true
            previewBtnArray[i].addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(self.previewImageClicked)))
            //print(previewBtnArray[i].tag)
            
        }
    }
    
    //랜덤 포스터
    @IBAction func playBtnAction(_ sender: UIButton) {
        poster.image = UIImage(named: posterArray[Int.random(in: 0...2)])
    }
    
}
