//
//  extention + Keyboard.swift
//  AppLogin
//
//  Created by roman Khilchenko on 14.08.2022.
//

import UIKit

//MARK: - extention для клавиатуры,чтобы не перекрывала контент
extension LoginViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbWillShow(_ notification: NSNotification) {
        let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        view.bounds.origin = CGPoint(x: 0, y: kbFrameSize.size.width / 8.5)
    }
    
    @objc private func kbWillHide() {
        view.bounds.origin = CGPoint.zero
    }
}

