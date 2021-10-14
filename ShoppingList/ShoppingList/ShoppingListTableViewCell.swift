//
//  ShoppingListTableViewCell.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/10/14.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var cellBackgroundview: UIView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    static let identifier = "ShoppingListTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundview.backgroundColor = .systemGray6
        bookmarkImage.tintColor = .black
        checkImage.tintColor = .black
        selectionStyle = .none
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
