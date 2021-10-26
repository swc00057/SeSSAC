//
//  BoxOfficeTableViewCell.swift
//  DailyBoxOffice
//
//  Created by 신동원 on 2021/10/26.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {
    
    static let identifier = "BoxOfficeTableViewCell"
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
