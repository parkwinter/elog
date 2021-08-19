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

        NetworkManager.getUserInfos { users in
            if let userArray = users?.result {
                print(userArray[0].email)
//                UserManger.shared.id = userArray[0].email
            }
        }
        
        // 노트조회 테스트 -> 안됨
        NetworkManager.getAllNoteTest(userId: "1") { allNoteTest in
           if let noteArray = allNoteTest?.result {
                print(noteArray[0].title)
            }
        }
    }

    @IBAction func onTapButton(_ sender: Any) {
 
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignViewController")



        navigationController?.pushViewController(viewController, animated: true)
    }

}

