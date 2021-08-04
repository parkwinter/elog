//
//  ViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/05/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManager.getUserInfos()
    }

    @IBAction func onTapButton(_ sender: Any) {

        UserManger.shared.isUser = true

        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignViewController")



        navigationController?.pushViewController(viewController, animated: true)
    }

}

