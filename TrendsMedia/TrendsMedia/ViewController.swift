//
//  ViewController.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/17.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let tvshowInfo = TvShowInfo()
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainOverMenuView: UIView!
    @IBOutlet weak var mediaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaTableView.delegate = self
        mediaTableView.dataSource = self
        mediaTableView.separatorStyle = .none
        mainTitle.text = "SHIN DONG"
        mainTitle.textAlignment = .center
        mainTitle.textColor = .white
        mainTitle.font = .boldSystemFont(ofSize: 50)
        mainOverMenuView.layer.cornerRadius = 10
        mainOverMenuView.layer.shadowColor = UIColor.black.cgColor
        mainOverMenuView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mainOverMenuView.layer.shadowRadius = 10
        mainOverMenuView.layer.shadowOpacity = 0.3
        let backBarButtonItem = UIBarButtonItem(title: "MY MEDIA", style: .plain, target: self, action: nil)

        self.navigationItem.backBarButtonItem = backBarButtonItem

        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tvshowInfo.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell else{
            return UITableViewCell()
        }
        let row = tvshowInfo.tvShow[indexPath.row]
        cell.releaseLabel.text = row.releaseDate
        cell.genreLabel.text = "#"+row.genre
        cell.movieTitleLabel.text = row.title
        cell.starringLabel.text = row.starring
        cell.rateLabel.text = "\(row.rate)"
        cell.posterView.image = UIImage(named: "\(row.posterImage)")
        cell.webViewLinkButton.tag = indexPath.row
        cell.webViewLinkButton.addTarget(self, action: #selector(webViewLinkButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/1.8
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "CastViewController") as! CastViewController
        vc.tvShow = tvshowInfo.tvShow[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func webViewLinkButtonClicked(_ sender: UIButton){
       
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: linkViewController.identifier) as! linkViewController
        vc.tvshow = tvshowInfo.tvShow[sender.tag]
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }

    @IBAction func searchBtnClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        //vc.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
        
        //present(vc, animated: true, completion: nil)
        
    }
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: BookViewController.identifier) as! BookViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func mapButtonClicked(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: MapViewController.identifier) as! MapViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

