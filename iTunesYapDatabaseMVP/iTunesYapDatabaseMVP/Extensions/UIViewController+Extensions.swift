//
//  UIViewController+Extensions.swift
//  iTunesYapDatabaseMVP
//
//  Created by Ибрагим Габибли on 18.11.2025.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround(customView: UIView? = nil) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        (customView ?? view).addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        navigationController?.view.endEditing(true)
    }
}
