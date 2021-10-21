//
//  linkViewController.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/19.
//

import UIKit

class linkViewController: UIViewController {
    
    var tvshow: TvShow?
    
    static let identifier = "linkViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tvshow = tvshow else {
            return
        }

        navigationItem.title = tvshow.title

        // Do any additional setup after loading the view.
    }

}
