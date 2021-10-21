//
//  BookViewController.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/21.
//

import UIKit

class BookViewController: UIViewController {

    static let identifier = "BookViewController"
    let tvShowInfo = TvShowInfo()
    @IBOutlet weak var bookCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        //Book Collection view
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
    
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        bookCollectionView.collectionViewLayout = layout

        // Do any additional setup after loading the view.
    }
    

}

extension BookViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else{
            return UICollectionViewCell()
        }
        let tvShow = tvShowInfo.tvShow[indexPath.item]
        cell.layer.cornerRadius = 20
        cell.posterImageView.image = UIImage(named: tvShow.posterImage)
        cell.posterImageView.contentMode = .scaleAspectFit
        cell.rateLabel.text = String(tvShow.rate)
        cell.rateLabel.textColor = .white
        cell.titleLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        cell.titleLabel.textColor = .white
        cell.titleLabel.text = tvShow.title
        let randromColorNumber = Int.random(in: 1...6)
        cell.backgroundColor = UIColor(named: "CollectionViewColor-\(randromColorNumber)")
        return cell
    }
    
    
}
