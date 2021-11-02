//
//  ViewController.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/10/14.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    @IBOutlet weak var titlaLabel: UILabel!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    let localRealm = try! Realm()
    var tasks: Results<ShoppingListModel>!
//    var shoppingList = [ShoppingList]{
//        didSet{
//            //saveData()
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titlaLabel.textAlignment = .center
        titlaLabel.text = "쇼핑"
        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
//        shoppingListTableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: "ShoppingListTableViewCell")
        addTextField.placeholder = "무엇을 구매하실 건가요?"
        addTextField.backgroundColor = .systemGray6
        addBtn.setTitle("추가", for: .normal)
        addBtn.setTitleColor(.black, for: .normal)
        addBtn.backgroundColor = .systemGray5
        addBtn.layer.cornerRadius = 10
        tasks = localRealm.objects(ShoppingListModel.self)
        // Do any additional setup after loading the view.
    }
    func saveData(){
  
    }
    func loadData(){
        shoppingListTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell
        else{
            print("else")
            return ShoppingListTableViewCell()
        }
        let row = tasks[indexPath.row]
        cell.memoLabel.text = row.memo
        
        if row.bookmark{
            cell.bookmarkImage.image = UIImage(systemName:"star.fill")
        }
        else{
            cell.bookmarkImage.image = UIImage(systemName:"star")
        }
        if row.orderCheck{
            cell.checkImage.image = UIImage(systemName:"checkmark.square.fill")
        }
        else{
            cell.checkImage.image = UIImage(systemName:"checkmark.square")
        }
        cell.checkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.checkImageClicked)))
        cell.checkImage.isUserInteractionEnabled = true
        cell.checkImage.tag = indexPath.row
        cell.bookmarkImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.bookmarkImageClicked)))
        cell.bookmarkImage.isUserInteractionEnabled = true
        cell.bookmarkImage.tag = indexPath.row
        
            
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let taskToDelete = tasks[indexPath.row]
            try! localRealm.write {
                localRealm.delete(taskToDelete)
            }
        }
        loadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    @objc func checkImageClicked(_ sender: UITapGestureRecognizer) {
        print("check image clicked")
        guard let imgView = sender.view as? UIImageView else{return}
        let taskToUpdate = tasks[imgView.tag]
        if imgView.image == UIImage(systemName: "checkmark.square.fill") {
            try! localRealm.write {
                taskToUpdate.orderCheck = false
            }
        }
        else{
            try! localRealm.write {
                taskToUpdate.orderCheck = true
            }
        }
        loadData()
    }
    @objc func bookmarkImageClicked(_ sender: UITapGestureRecognizer) {
        print("bookmark image clicked")
        guard let imgView = sender.view as? UIImageView else{return}
        let taskToUpdate = tasks[imgView.tag]
        if imgView.image == UIImage(systemName: "star.fill") {
            try! localRealm.write {
                taskToUpdate.bookmark = false
            }
        }
        else{
            try! localRealm.write {
                taskToUpdate.bookmark = true
            }
        }
        loadData()
    }
    

    @IBAction func addBtnAction(_ sender: UIButton) {
        guard let text = addTextField.text else{return}
        
        if text.trimmingCharacters(in: .whitespaces) != ""{
            let task = ShoppingListModel(memo: text)
            try! localRealm.write {
                localRealm.add(task)
            }
            loadData()
        }
    }
    
}

