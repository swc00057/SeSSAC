//
//  overViewTableViewCell.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/19.
//

import UIKit

class overViewTableViewCell: UITableViewCell {

    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var overviewButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
