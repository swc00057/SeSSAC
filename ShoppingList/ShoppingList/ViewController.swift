//
//  ViewController.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/10/14.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    @IBOutlet weak var titlaLabel: UILabel!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    var shoppingList = [ShoppingList](){
        didSet{
            saveData()
        }
    }
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
        loadData()
        
        // Do any additional setup after loading the view.
    }
    func saveData(){
        print("save")
        
        var list: [[String:Any]] = []
        for i in self.shoppingList{
            let arrayList: [String:Any] = [
                "memo" : i.memo,
                "bookmark" : i.bookmark.rawValue,
                "orderCheck" : i.orderCheck.rawValue
                ]
            list.append(arrayList)
        }
        UserDefaults.standard.set(list, forKey: "shoppingList")
        shoppingListTableView.reloadData()
        
    }
    func loadData(){
        
        if let data = UserDefaults.standard.object(forKey: "shoppingList") as? [[String:Any]]{
            var list = [ShoppingList]()
            for datum in data {
                guard let memo = datum["memo"] as? String else {return}
                guard let bookmark = datum["bookmark"] as? Int else {return}
                guard let orderCheck = datum["orderCheck"] as? Int else {return}
                let enumBookmark = Bookmark(rawValue: bookmark) ?? .off
                let enumOrderCheck = OrderCheck(rawValue: orderCheck) ?? .none
                
                list.append(
                    ShoppingList(
                        memo:memo,bookmark:enumBookmark,orderCheck:enumOrderCheck
                    )
                )
            }
            self.shoppingList = list
        }
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell
        else{
            print("else")
            return ShoppingListTableViewCell()
        }
        
        cell.memoLabel.text = shoppingList[indexPath.row].memo
        
        if shoppingList[indexPath.row].bookmark.rawValue == 1{
            cell.bookmarkImage.image = UIImage(systemName:"star.fill")
        }
        else{
            cell.bookmarkImage.image = UIImage(systemName:"star")
        }
        if shoppingList[indexPath.row].orderCheck.rawValue == 1{
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
        print("cell init")
        
        
            
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            shoppingList.remove(at: indexPath.row)
        }
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
        if imgView.image == UIImage(systemName: "checkmark.square.fill") {
            self.shoppingList[imgView.tag].orderCheck = OrderCheck.none
        }
        else{
            self.shoppingList[imgView.tag].orderCheck = OrderCheck.check
        }
        
    }
    @objc func bookmarkImageClicked(_ sender: UITapGestureRecognizer) {
        print("bookmark image clicked")
        guard let imgView = sender.view as? UIImageView else{return}
        if imgView.image == UIImage(systemName: "star.fill") {
            self.shoppingList[imgView.tag].bookmark = Bookmark.off
        }
        else{
            self.shoppingList[imgView.tag].bookmark = Bookmark.on
        }
    }
    

    @IBAction func addBtnAction(_ sender: UIButton) {
        guard let text = addTextField.text else{return}
        
        if text.trimmingCharacters(in: .whitespaces) != ""{
            let list = ShoppingList(memo: text,
                                    bookmark: .off,
                                    orderCheck: .none)
            print(list)
            shoppingList.append(list)
            print(shoppingList)
        }
    }
    
}

