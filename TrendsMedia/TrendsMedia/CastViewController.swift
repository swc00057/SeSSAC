//
//  CastViewController.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/17.
//

import UIKit
import Kingfisher

class CastViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var tvShow: TvShow?
    var overviewDetail: Bool = false {
        didSet{
            castTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        castTableView.dataSource = self
        castTableView.delegate = self
        castTableView.rowHeight = UITableView.automaticDimension
        guard let tvShow = tvShow else {
            return
        }
        let posterImage = UIImage(named: tvShow.posterImage)
        posterImageView.image = posterImage
        posterImageView.contentMode = .scaleAspectFill
        
        //kingfisher library
        let url = URL(string: tvShow.backdropImage)
        backDropImageView.kf.setImage(with: url)
        
        //titleLabel
        let title = tvShow.title
        titleLabel.text = title
        titleLabel.textColor = .white
        
        
        
        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "overViewTableViewCell", for: indexPath) as? overViewTableViewCell else{
                return UITableViewCell()
            }
            cell.overViewLabel.text = tvShow?.overview
            cell.overViewLabel.numberOfLines = overviewDetail == true ? 0 : 2
            cell.overviewButton.tag = indexPath.row
            let image = overviewDetail ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            cell.overviewButton.setImage(image, for: .normal)
            cell.overviewButton.addTarget(self, action: #selector(overviewButtonClicked), for: .touchUpInside)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell else{
                return UITableViewCell()
            }
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : UIScreen.main.bounds.height/9
    }
    
    @objc func overviewButtonClicked(_ sender: UIButton){
        
        overviewDetail = !overviewDetail
        let image = overviewDetail ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        
        sender.setImage(image, for: .normal)
        
    }
    
}
