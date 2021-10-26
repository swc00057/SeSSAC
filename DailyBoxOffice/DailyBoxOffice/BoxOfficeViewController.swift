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

    //@IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var boxOfficeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.backgroundColor = .clear
        //textField.contentVerticalAlignment = .center
        //textField.font = .systemFont(ofSize: 17)
        searchButton.backgroundColor = .white
        searchButton.setTitle("검색", for: .normal)
        let nibName = UINib(nibName: BoxOfficeTableViewCell.identifier, bundle: nil)
        boxOfficeTableView.register(nibName, forCellReuseIdentifier: BoxOfficeTableViewCell.identifier)
        fetchBoxOffice()
        // Do any additional setup after loading the view.
    }
    
    func fetchBoxOffice(){
        let date = "20211024"
        var API_KEY: String = ""
        if let key = Bundle.main.infoDictionary?["API_KEY"] as? String {
            API_KEY = key
        }
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(API_KEY)=\(date)"
        print(url)
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension BoxOfficeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        return cell
    }
    
}
