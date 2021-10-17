//
//  CastViewController.swift
//  TrendsMedia
//
//  Created by 신동원 on 2021/10/17.
//

import UIKit

class CastViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var castTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        castTableView.dataSource = self
        castTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as? CastTableViewCell else{
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/9
    }
    

}
