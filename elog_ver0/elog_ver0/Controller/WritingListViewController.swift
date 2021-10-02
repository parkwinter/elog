//
//  WritingListViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/10/02.
//

import UIKit

class WritingListViewController: UIViewController {
   
    
    var note: Note? = UserManger.shared.currentNote
    var writings : [Writing] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noteDate: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beforeTransition()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(navigationItemTapped))
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("WritingListViewWillAppear")
        loadWritings()
        

    }
    
    @objc func navigationItemTapped() {
        print("add button!!!")
        //showCreateNoteAlert()

    }
    func beforeTransition() {
        navigationItem.title = note?.title
        self.noteDate?.text = note?.created_at
        
    }


    func loadWritings(){
        NetworkManager.getAllWritings(noteIdx: note!.id){ [weak self] allWritings in
            guard let self = self else { return }
            let writings = allWritings?.result ?? []
            self.writings = writings
            print("writings 시발 갯수는~ \(self.writings.count)")
        }
        
        print("writings 갯수는~ \(self.writings.count)")
    }
    
}

extension WritingListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("hi
        print("writings count~")
        print(self.writings.count)
        return self.writings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    
        var writing = self.writings[indexPath.row]
        print("시발,, \(writing)")
        print("노트에 있는 롸이팅들은 \(self.writings[indexPath.row])")
        cell.textLabel?.text = writing.title
        //cell.textLabel?.text = note?.title[indexPath]
        //cell.textLabel?.text = "\(indexPath.row)"

        return cell
    }
    
}
