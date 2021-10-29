//
//  BoxOfficeViewController.swift
//  DailyBoxOffice
//
//  Created by 신동원 on 2021/10/26.
//

import UIKit
import Alamofire
import SwiftyJSON

class BoxOfficeViewController: UIViewController {

    var boxOfficeList: [BoxOffice] = []
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var boxOfficeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.backgroundColor = .clear
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        let nibName = UINib(nibName: BoxOfficeTableViewCell.identifier, bundle: nil)
        boxOfficeTableView.register(nibName, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        fetchBoxOffice()
    }
    
    func fetchBoxOffice(){
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
                var list: [BoxOffice] = []
                let json = JSON(value)
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue{
                    let title = item["movieNm"].stringValue
                    let rank = item["rank"].stringValue
                    let releaseDate = item["openDt"].stringValue
                    let movie = BoxOffice(title: title, rank: rank, releaseDate: releaseDate)
                    list.append(movie)
                }
                self.boxOfficeList = list
                self.boxOfficeTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        fetchBoxOffice()
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
