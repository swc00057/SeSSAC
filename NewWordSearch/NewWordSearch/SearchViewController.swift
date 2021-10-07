//
//  SearchViewController.swift
//  NewWordSearch
//
//  Created by 신동원 on 2021/10/07.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var userLabel: UILabel!
    @IBOutlet var userText: UITextField!
    @IBOutlet var tagBtn1: UIButton!
    @IBOutlet var tagBtn2: UIButton!
    @IBOutlet var tagBtn3: UIButton!
    @IBOutlet var tagBtn4: UIButton!
    var titleArray: [String] = []
    var tagBtnArray: [UIButton] = []
    let newWordDic: [String:String] = [
        "반모":"'반말모드'의 줄임말"
        ,"오하운":"'오늘 하루 운동'이라는 뜻으로 생활 밀착형 운동을 말한다."
        ,"코시국":"'코로나19 바이러스 시국'의 줄임말이다"
        ,"여미새":"'여자에 미친 ㅅㄲ'의 줄임말이다. 여자를 밝히는 사람을 지칭한다"
        ,"남미새":"'남자에 미친 ㅅㄲ'의 줄임말이다. 남자를 밝히는 사람을 지칭한다"
        ,"머선129":"'무슨 일이야?'를 사투리 섞어 우스꽝스럽게 발음해서 '머선 일이고?'로 들리는데 뒤에 일이고를 숫자 129로 바꾸어 표현한 말이다"
        ,"방방봐":"인터넷 방송 신조어. '방송은 방송으로만 봐라'의 줄임말"
        ,"구취":"인터넷 방송 신조어. '구독취소'의 줄임말"
        ,"무물":"'무엇이든지 물어보세요'의 줄임말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSetup()

    }
    
    func btnSetup(){
        tagBtnArray.append(tagBtn1)
        tagBtnArray.append(tagBtn2)
        tagBtnArray.append(tagBtn3)
        tagBtnArray.append(tagBtn4)
        for i in 0..<tagBtnArray.count{
            tagBtnArray[i].isHidden = true
            tagBtnArray[i].setTitle("", for: .normal)
            tagBtnArray[i].layer.cornerRadius = 10
        }
        
    }
    func addHashTag(tagWord: String){
        if titleArray.count == 4 {
            titleArray.remove(at: 3)
        }
        titleArray.insert(tagWord, at: 0)
        for i in 0..<titleArray.count{
            tagBtnArray[i].setTitle(titleArray[i], for: .normal)
            tagBtnArray[i].isHidden = false
        }
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        
        let word: String = userText.text!
        let wordValue: String? = newWordDic[word]
        
        if let searchResult = wordValue{
            userLabel.text = searchResult
            addHashTag(tagWord: word)
        }
        else {
            userLabel.text = "결과 없음"
        }
    }
    
    

}
