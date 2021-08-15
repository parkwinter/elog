//
//  CreateViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/11.
//

// youtube 참고 : https://www.youtube.com/watch?v=K_4ZwerOxDs


import UIKit
import HSCycleGalleryView

class CreateViewController: UIViewController, HSCycleGalleryViewDelegate {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pagerContainer: UIView!
    
    let pager = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // https://www.hackingwithswift.com/example-code/uikit/how-to-add-a-bar-button-to-a-navigation-bar
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigationItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(navigationItemTapped))

        // carousel ui init
        pager.register(cellClass: PagerCell.self, forCellReuseIdentifier: "PagerCell")
        pager.delegate = self
        pagerContainer.addSubview(pager)
        pager.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")

    }

    @objc func navigationItemTapped() {
        print("add button!!!")
        showCreateNoteAlert()

    }
    
    func changePageControl(currentIndex: Int) {
        pageControl.currentPage = currentIndex
    }
    
    func numberOfItemInCycleGalleryView(_ cycleGalleryView: HSCycleGalleryView) -> Int {
        let count = 3
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        return count
    }
    
    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = cycleGalleryView.dequeueReusableCell(withIdentifier: "PagerCell", for: IndexPath(item: index, section: 0)) as! PagerCell
        
        cell.backgroundColor = UIColor.black
        return cell
    }

    func showCreateNoteAlert() {
        // https://stackoverflow.com/questions/26567413/get-input-value-from-textfield-in-ios-alert-in-swift

        let alert = UIAlertController(title: "노트 제목을 입력해주세요",
                                      message: "나만의 노트 이름을 만들어 볼까요?",
                                      preferredStyle: .alert)

        alert.addTextField { textField in textField.text = "나의 일기장" }

/*
         이걸 축약한 형태 입니다.
        alert.addTextField(configurationHandler: { textField in
            textField.text = "나의 일기장"
        })
*/
        let action = UIAlertAction(title: "생성하기", style: .default) { [weak alert] _ in
            let textField = alert?.textFields![0]
            let title = textField?.text ?? ""
            print("생성하기가 눌렸습니다. \(title)")

            // 생성하기 함수 호출
            self.createNote(title: title)
        }

        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func createNote(title: String) {
        let email = UserManger.shared.email ?? ""

        print("API 호출: createNote()")
        NetworkManager.createNote(title: title, email: email) { noteResponse in
            print("API Response 도착")
            print(noteResponse)
        }

    }

}
