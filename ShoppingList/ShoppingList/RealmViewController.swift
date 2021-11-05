//
//  ViewController.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/10/14.
//

import UIKit
import RealmSwift
import Zip

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
        print("load")
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
    
    @IBAction func backupRestoreButtonClicked(_ sender: UIButton) {
        //액션시트를 열어 백업/복구 선택
        showActionSheet(title: "백업&복구", message: "")
    }
    
}

extension RealmViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(#function)
        
        //복구 - 2. 선택한 파일에 대한 경로 가져와야 함
        guard let selectedFileURL = urls.first else { return }
        
        //도큐먼트 디렉토리 경로는 한번만 잡아주면 될 듯?
        //FileManager.default.urls 랑 FileManager.
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = documentDirectory.appendingPathComponent(selectedFileURL.lastPathComponent)
        //설정된 변수 sandboxFileURL 는 쉽게말해 실행되는 앱의 도큐멘트 디렉토리이다
        //lastPathComponent는 path의 맨 뒷부분을 말하는 것 같다. 여기서는 파일명+확장자가 된다
        /*
         따라서 도큐멘트픽커로 선택한 파일의 경로에서 파일명+확장자만 가져와서 사용중인 앱의 도큐멘트 디렉토리
         경로 뒤에 붙여주어 url을 생성하는 작업을 진행하는 것. 터미널 등을 이용하여 cp를 하는 것과 유사하다
         */
        
        do {
            let fileURL = sandboxFileURL
            
            try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
                self.showAlert(title: "", message: "복구가 완료 되었습니다. 앱을 재시작 해주세요!")
                //print("progress: \(progress)")
                //복구가 완료 되었습니다 메시지, 얼럿.
            }, fileOutputHandler: { unzippedFile in
                //print("unzippedFile: \(unzippedFile)")
            })
            
        } catch{
            print("error")
        }
        
    }
}


