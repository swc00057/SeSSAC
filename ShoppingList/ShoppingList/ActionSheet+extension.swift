//
//  ActionSheet+extension.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/11/04.
//

import UIKit

extension RealmViewController {
    
    func showActionSheet(title: String, message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let backup = UIAlertAction(title: "백업하기", style: .default) { _ in
            if BackupAndRestore.shared.backup(){
                self.showAlert(title: "", message: "백업이 완료 되었습니다.")
            }
            self.presentActivityViewController()
            
        }
        let restore = UIAlertAction(title: "복구하기", style: .default) { _ in
            let documentPicker = BackupAndRestore.shared.restore()
            documentPicker.delegate = self
            self.present(documentPicker, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(backup)
        actionSheet.addAction(restore)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true)
    }
    func presentActivityViewController() {
        //압축파일 경로
        let fileName = (BackupAndRestore.shared.documentDirectory()! as NSString).appendingPathComponent("shoppingList.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities:[])
        self.present(vc, animated: true)
    }
    
}
