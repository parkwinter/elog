//
//  MenuViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/05/21.
//

import UIKit

enum MenuType: Int {
    case 노트제목
    case camera
    case profile
}

class MenuViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row)
        else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
}
