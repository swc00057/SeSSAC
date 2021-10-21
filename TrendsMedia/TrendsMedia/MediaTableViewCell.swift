//
//  MediaTableViewCell.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/17.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var mediaCellView: UIView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var starringLabel: UILabel!
    @IBOutlet weak var rateLabel: PaddedLabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var webViewLinkButton: UIButton!
    static let identifier = "MediaTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        detailBtn.setTitle("자세히 보기", for: .normal)
        genreLabel.font = .boldSystemFont(ofSize: 17)
        self.selectionStyle = .none
        posterView.layer.cornerRadius = 10
        posterView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mediaCellView.layer.cornerRadius = 10
        mediaCellView.layer.shadowColor = UIColor.black.cgColor
        mediaCellView.layer.shadowOffset = CGSize(width: 0, height: 4)
        mediaCellView.layer.shadowRadius = 10
        mediaCellView.layer.shadowOpacity = 0.3
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
    }

}
