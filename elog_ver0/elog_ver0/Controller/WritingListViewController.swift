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
        showCreateWritingAlert()

    }
    func showCreateWritingAlert() {
        
        let alert = UIAlertController(title: "글을 추가해보자 !",
                                      message: "제목, 부제목 설졍해줘",
                                      preferredStyle: .alert)

        alert.addTextField { textField in textField.text = "Title" }
        alert.addTextField { textField in textField.text = "SubTitle" }

        /*
         이걸 축약한 형태 입니다.
         alert.addTextField(configurationHandler: { textField in
         textField.text = "나의 일기장"
         })
         */
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let action = UIAlertAction(title: "생성하기", style: .default) { [weak alert] _ in
            //let textField = alert?.textFields![0]
//            let title = textField?.text ?? ""
            let title = alert?.textFields![0].text ?? ""
            let subtitle = alert?.textFields![1].text ?? ""
            
            print("생성하기가 눌렸습니다. \(title) & \(subtitle)")

            // 생성하기 함수 호출
            //self.createNote(title: title)
            self.putWritings(title: title, subtitle: subtitle, content: "안녕! 무엇을 더 입력할까?")
            
        }
        alert.addAction(cancel)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func beforeTransition() {
        navigationItem.title = note?.title
        self.noteDate?.text = note?.created_at
        
        
    }


    func loadWritings(){
        print("view will appear loadWritings함수 호출")
        print(self.note?.title)
        
        NetworkManager.getAllWritings(noteIdx: note!.id){ [weak self] allWritings in
            guard let self = self else { return }
            let writings = allWritings?.result ?? []
            self.writings = writings
            print("writings 갯수는~ \(self.writings.count)")
            self.tableView.reloadData()
        }
        
        print("writings 갯수는~ \(self.writings.count)")
    }
    
    func putWritings(title: String?, subtitle: String?, content: String?){
        // 글 생성
        
        let noteId = self.note?.id
        //let content = ""
        let img = ""
        
        NetworkManager.createWritings(title: title ?? "", subtitle: subtitle ?? "", content: content ?? "", img: img, noteId: noteId!){ allWritings in
            
            print("note에 글 생성 api 호출")
            self.loadWritings()
        }
    }
    
}


extension WritingListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("hi
        print("writings count~")
        print(self.writings.count)
        return self.writings.count
        //return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
    
        var writing = self.writings[indexPath.row]
        //print("시발,, \(writing)")
        //
        //print("노트에 있는 롸이팅들은 \(self.writings[indexPath.row])")
        print("writings title : \(writing.title)")
        cell.textLabel?.text = writing.content
        //cell.textLabel?.text = note?.title[indexPath]
        //cell.textLabel?.text = "\(indexPath.row)"

        //print("클린된 라이팅 아이디는 : \(writing.id)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "sgWriting", sender: indexPath.row)
        print("클릭된 라이팅 아이디는 : \(self.writings[indexPath.row].id)")
        let clickedWriting = self.writings[indexPath.row]

        print("clickedWriting : \(clickedWriting.content)")

        UserManger.shared.currentWriting = clickedWriting
        
    }
    
}
