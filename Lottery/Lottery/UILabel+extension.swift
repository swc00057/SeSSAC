//
//  UILabel+extension.swift
//  Lottery
//
//  Created by 신동원 on 2021/10/29.
//

import UIKit

extension UILabel {
    
    func lottoBall(){
        self.textAlignment = .center
        self.font = .boldSystemFont(ofSize: 17)
        self.textColor = .white
        self.layer.cornerRadius = frame.height/2
        self.clipsToBounds = true
    }
}

