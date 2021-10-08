//
//  UserSetViewController.swift
//  LetsDrinkWater
//
//  Created by 신동원 on 2021/10/08.
//

import UIKit
import TextFieldEffects

class UserSetViewController: UIViewController {

    
    @IBOutlet var nickTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var weightTextField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(named: "bgcolor")
        self.navigationController?.navigationBar.tintColor = .white
        

        // Do any additional setup after loading the view.
    }
    

}
