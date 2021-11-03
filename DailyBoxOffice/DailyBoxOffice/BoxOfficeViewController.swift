//
//  BoxOfficeViewController.swift
//  DailyBoxOffice
//
//  Created by 신동원 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class BoxOfficeViewController: UIViewController {

    var boxOfficeList = List<DailyBoxOfficeModel>()
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var boxOfficeTableView: UITableView!
    let localRealm = try! Realm()
    var tasks: Results<BoxOfficeModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.backgroundColor = .clear
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        let nibName = UINib(nibName: BoxOfficeTableViewCell.identifier, bundle: nil)
        boxOfficeTableView.register(nibName, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        //fetchBoxOffice()
        tasks = localRealm.objects(BoxOfficeModel.self)
        loadDataFromRealm()
        //fetchBoxOffice()
    }
    func loadDataFromRealm() {
        print("load Data from Realm")
        var date: String
        //빈문자열 일 시 어제 날짜로 입력
        if searchTextField.text?.replacingOccurrences(of: " ", with: "") == ""{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            
            let calendar = Calendar.current
            let yesterday = calendar.date(byAdding: .day, value: -1, to: Date() )
            date = formatter.string(from: yesterday!)
            print(date)
        }
        else{
            date = searchTextField.text!
        }
        //검색한 날짜를 필터로 Realm에서 읽어와 tableView를 재구성 함
        if let items = tasks.filter("searchDate == \"\(date)\"").first{
            let list = List<DailyBoxOfficeModel>()
            for item in items.dailyBoxOffice{
                let title = item.title
                let rank = item.rank
                let releaseDate = item.releaseDate
                let movie = DailyBoxOfficeModel(title: title, rank: rank, releaseDate: releaseDate)
                list.append(movie)
            }
            boxOfficeList = list
            boxOfficeTableView.reloadData()
        }
        //Realm에 없을 시, API를 이용해 새로 데이터를 받아옴
        else{
            print("Not Data")
            fetchBoxOffice()
        }
        
    }
    
    func fetchBoxOffice(){
        print("fetch New Data")
        var date: String
        if searchTextField.text?.replacingOccurrences(of: " ", with: "") == ""{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
//            var now = Date()
//            now = now.addingTimeInterval(-86400)
//            date = formatter.string(from: now)
            
            //1. 어제 날짜 구하기
            let calendar = Calendar.current
            let yesterday = calendar.date(byAdding: .day, value: -1, to: Date() )
            date = formatter.string(from: yesterday!)
            print(date)
            
/*            //2. 이번주 월요일은?
            var component = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: Date())
            component.weekday = 2
            let mondayWeek = calendar.date(from: component)
            print(mondayWeek)
*/
        }
        
        else{
            date = searchTextField.text!
        }
        
        
        var API_KEY: String = ""
        if let key = Bundle.main.infoDictionary?["API_KEY"] as? String {
            API_KEY = key
        }
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(API_KEY)=\(date)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let list = List<DailyBoxOfficeModel>()
                let json = JSON(value)
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue{
                    let title = item["movieNm"].stringValue
                    let rank = item["rank"].stringValue
                    let releaseDate = item["openDt"].stringValue
                    let movie = DailyBoxOfficeModel(title: title, rank: rank, releaseDate: releaseDate)
                    list.append(movie)
                }
                //받은 데이터를 DailyBoxOfficeModel에 담아서 검색 날짜와 함께 새로운 컬럼을 추가한다
                let task = BoxOfficeModel(searchDate: date, dailyBoxOffice: list)
                try! self.localRealm.write {
                    self.localRealm.add(task)
                }
                self.loadDataFromRealm()
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let text = searchTextField.text ?? ""
        //올바른 날짜를 입력했는지 체크하기 위해 Date형으로 변환 시도
        if dateFormatter.date(from: text) != nil{
            loadDataFromRealm()
        }
        else {
            print("String error")
        }
    }
}
extension BoxOfficeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOfficeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else{
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.titleLabel.textColor = .white
        cell.titleLabel.font = .boldSystemFont(ofSize: 17)
        cell.dateLabel.textColor = .white
        cell.numberLabel.backgroundColor = .white
        cell.numberLabel.font = .boldSystemFont(ofSize: 17)
        cell.titleLabel.text = boxOfficeList[indexPath.row].title
        cell.numberLabel.text = boxOfficeList[indexPath.row].rank
        cell.dateLabel.text = boxOfficeList[indexPath.row].releaseDate
        return cell
    }
    
}
