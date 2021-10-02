//
//  WritingListViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/10/02.
//

import UIKit

class WritingListViewController: UIViewController {
  
    var note: Note? = UserManger.shared.currentNote
    
    
    @IBOutlet weak var noteDate: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beforeTransition()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(navigationItemTapped))
        
        
    }
    
    @objc func navigationItemTapped() {
        print("add button!!!")
        //showCreateNoteAlert()

    }
    func beforeTransition() {
        navigationItem.title = note?.title
        self.noteDate?.text = note?.created_at
    }


    
    
}

extension WritingListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi")
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        print("hi")
        return cell
    }
    
}
