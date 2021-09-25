//
//  UIViewController+Extension.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/21.
//

import UIKit

extension UIViewController {

    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
