//
//  BackupAndRestore.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/11/04.
//

import UIKit
import Zip
import MobileCoreServices
import UniformTypeIdentifiers

class BackupAndRestore {
    
    static let shared = BackupAndRestore()
    
    func backup() -> Bool {
        print(documentDirectory()!)
        var urlPaths = [URL]()
        
        if let path = documentDirectory(){
            let realm = (path as NSString).appendingPathComponent("default.realm")
            print(realm)
            //2-1. 백업하고자 하는 파일 확인
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            }
            else {
                print("백업할 파일이 없습니다.")
            }
        }
        
        //3. 백업
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "shoppingList") // Zip
            return true
        }
        catch {
          return false
        }
    }
    func restore() -> UIDocumentPickerViewController {
        //파일앱 열기
        let documentPicker: UIDocumentPickerViewController
        //14.0 이상
        //처음 사용해 봤는데 잘되는 것 같다 번외로 확장자 pdf만 걸러낼 수도 있다 더 좋은듯.. ex) UTType.pdf
        if #available(iOS 14.0, *) {
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.archive])
        }
        //14.0 미만
        else {
            documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        }
        return documentPicker
    }
    
    func documentDirectory() -> String? {
        //도큐멘트 디렉토리 경로
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        }
        else {
            return nil
        }
    }
}
