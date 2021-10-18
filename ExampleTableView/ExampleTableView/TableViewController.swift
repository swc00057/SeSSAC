//
//  TableViewController.swift
//  ExampleTableView
//
//  Created by 신동원 on 2021/10/12.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var titlaLabel: UILabel!
    let sectionArray: [String] = ["전체 설정","개인 설정","기타"]
    let rowArray: [[String]] = [["공지사항","실험실","버전정보"],["개인/보안","알림","채팅","멀티프로필"],["고객센터/도움말"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        titlaLabel.text = "설정"
        titlaLabel.textAlignment = .center

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    //섹션의 갯수 지정
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //섹션 배열의 요소 갯수 리턴
        return sectionArray.count
    }

    //각 섹션의 로우 갯수 지정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //로우 배열에서 섹션별 요소의 갯수 리턴
        return rowArray[section].count
    }
    
    //각 섹션의 헤더 값 지정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //섹션 배열의 요소 값(헤더값이됨) 리턴
        return sectionArray[section]
    }
    
    //셀 디자인 및 데이터 처리
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //옵셔널 바인딩
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") else {
            return UITableViewCell()
        }
        
        //섹션과 로우의 좌표 값으로 로우배열 요소값 읽어와 텍스트로 지정
        cell.textLabel?.text = rowArray[indexPath.section][indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 12)
        
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
