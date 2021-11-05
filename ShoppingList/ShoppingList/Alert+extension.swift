//
//  Alert+extension.swift
//  ShoppingList
//
//  Created by 신동원 on 2021/11/04.
//

import UIKit
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(OK)
        
        self.present(alert, animated: true)
    }
}
