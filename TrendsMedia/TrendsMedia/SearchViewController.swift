//
//  SearchViewController.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var movieData: [MovieModel] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var startPage = 1
    var totalCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchMovieData()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        searchBar.delegate = self
        //searchBar.showsCancelButton = true
        navigationItem.title = "영화 검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
    }
    //TMDB 영화검색
    func fetchMovieData(_ query: String){
        guard let title = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{return}
        let url = "https://api.themoviedb.org/3/search/movie?api_key=c68ead7746c5c59bec67daebd65678a3&query=\(title)&language=ko&page=\(startPage)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                self.totalCount = json["total_results"].intValue
                for item in json["results"].arrayValue {
                    let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    let image = "https://image.tmdb.org/t/p/w500" + item["poster_path"].stringValue
                    let linkData = ""
                    let userRating = ""
                    let subTitle = ""
                    let overview = item["overview"].stringValue
                    let releaseDate = item["release_date"].stringValue
                    let data = MovieModel(titleData: title, imageData: image, linkData: linkData, userRatingData: userRating, subtitle: subTitle, overview: overview, releaseDate: releaseDate)
                    self.movieData.append(data)

                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func closeButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("movieData count = \(movieData.count)")
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else{
            return UITableViewCell()
        }
        //포스터 이미지
        if let url = URL(string: movieData[indexPath.row].imageData){
            cell.posterView.kf.setImage(with:url)
        }
        else{
            cell.posterView.image = UIImage(systemName: "star")
        }
        //개봉일
        cell.releaseLabel.text = movieData[indexPath.row].releaseDate
        //타이틀
        cell.titleLabel.text = movieData[indexPath.row].titleData
        //줄거라
        cell.overviewLabel.text = movieData[indexPath.row].overview
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/7
    }
}

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let text = searchBar.text {
            //배열 초기화
            movieData.removeAll()
            //시작페이지 초기화
            startPage = 1
            fetchMovieData(text)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        movieData.removeAll()
        startPage = 1
        tableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
}
//cellforrow 보다 먼저 호출됨
extension SearchViewController: UITableViewDataSourcePrefetching {
    
    //셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row && movieData.count < totalCount {
                startPage += 1
                fetchMovieData(searchBar.text!)
                print(movieData.count)
                print("page:\(startPage)")
                print("prefetch: \(indexPaths)")
            }
        }
    }
    //취소
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소\(indexPaths)")
    }
    
    
}
