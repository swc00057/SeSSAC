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
    //태그버튼 타이틀을 담을 배열
    var titleArray: [String] = []
    //태그버튼 객체를 담을 배열
    var tagBtnArray: [UIButton] = []
    //단어 목록
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
        //버튼 및 기타설정
        btnSetup()

    }
    
    func btnSetup(){
        //태그 버튼 배열에 태그버튼 추가
        tagBtnArray.append(tagBtn1)
        tagBtnArray.append(tagBtn2)
        tagBtnArray.append(tagBtn3)
        tagBtnArray.append(tagBtn4)
        //태그버튼 타이틀,히든,둥근모서리 설정
        for i in 0..<tagBtnArray.count{
            tagBtnArray[i].isHidden = true
            tagBtnArray[i].setTitle("", for: .normal)
            tagBtnArray[i].layer.cornerRadius = 10
        }
        
    }
    //해쉬태그 추가 함수
    func addHashTag(tagWord: String){
        //태그버튼은 총4개로 그 이상은 삭제
        if titleArray.count == 4 {
            titleArray.remove(at: 3)
        }
        //이미 태그버튼 타이틀에 포함되어 있는지 판단 후 존재하면 삭제
        if let existWord: Int = titleArray.firstIndex(of: tagWord){
            titleArray.remove(at:existWord)
        }
        //검색한 단어 타이틀배열에 추가
        titleArray.insert(tagWord, at: 0)
        //타이틀 배열 리스트 태그버튼 타이틀로 매칭
        for i in 0..<titleArray.count{
            tagBtnArray[i].setTitle(titleArray[i], for: .normal)
            tagBtnArray[i].isHidden = false
        }
    }
    //검색한 단어가 단어 목록에 포함 되어 있는지 판단하고, 그에 따른 기능 실행
    func searchAction(){
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
    
    //상단 검색 버튼 액션
    @IBAction func searchBtnAction(_ sender: UIButton) {
        //단어 검색 함수 실행
        searchAction()
        //키보드 내림
        self.view.endEditing(true)
    }
    //제스쳐로 키보드 내림
    @IBAction func tabGesture(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //리턴버튼을 DONE(didOnEndExit)으로 검색 버튼 액션과 같은 기능
    @IBAction func didEndOnExit(_ sender: UITextField) {
        searchAction()
    }
    //해시태그 클릭 시 텍스트필드에 해시태그 문자열 추가
    @IBAction func tagBtnAction(_ sender: UIButton) {
        userText.text = sender.currentTitle
    }
}
