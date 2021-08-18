//
//  CreateViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/11.
//

// youtube 참고 : https://www.youtube.com/watch?v=K_4ZwerOxDs


import UIKit
import HSCycleGalleryView

class CreateViewController: UIViewController {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pagerContainer: UIView!
    
    let pager = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))

    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // https://www.hackingwithswift.com/example-code/uikit/how-to-add-a-bar-button-to-a-navigation-bar
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigationItemTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(navigationItemTapped))

        // carousel ui init

        // 이거는 프로그래밍 코드로만 cell 을 생성했을 때 사용
        // pager.register(cellClass: PagerCell.self, forCellReuseIdentifier: "PagerCell")

        // 이거는 xib 로 만들었을 때, xib 파일 이름을 명시해줘야 함.
        pager.register(nib: UINib(nibName: "PagerCell", bundle: nil),
                       forCellReuseIdentifier: "PagerCell")


        pager.delegate = self
        pagerContainer.addSubview(pager)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        loadNotes()

    }

    func loadNotes() {
        // 아래 API 가 동작을 안하기 때문에 임시로 데이터를 넣어줬습니다.
        notes = [
            Note(title: "임시 노트1", image: "https://www.dliflc.edu/wp-content/uploads/2018/11/book.jpg"),
            Note(title: "임시 노트2", image: "https://www.collinsdictionary.com/images/full/book_181404689_1000.jpg"),
            Note(title: "임시 노트3", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Book.svg/1200px-Book.svg.png"),
            Note(title: "임시 노트4", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSO1tsNyinr3i1ABbUqS8SouEmRJvH2XcBq2g&usqp=CAU"),
            Note(title: "임시 노트5", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQK5IihBujgFhc843Y1CkhQUts8iqXUryJafQ&usqp=CAU"),
        ]

//        NetworkManager.getAllNote(userId: UserManger.shared.id ?? "") { [weak self] allNoteResponse in
//            guard let self = self else { return }
//            let notes = allNoteResponse?.result ?? []
//            self.notes = notes
//
//        }


        // 그 다음 reloadData 를 해줘야지만 ui가 갱신됩니다.
        pager.reloadData()

    }

    @objc func navigationItemTapped() {
        print("add button!!!")
        showCreateNoteAlert()

    }

    func showCreateNoteAlert() {
        // https://stackoverflow.com/questions/26567413/get-input-value-from-textfield-in-ios-alert-in-swift

        let alert = UIAlertController(title: "노트 제목 정해줘 !",
                                      message: "ex. 2021 일기장",
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
        // FIXME: Remove email
        let email = ""

        print("API 호출: createNote()")
        NetworkManager.createNote(title: title, email: email) { [weak self] noteResponse in
            print("API Response 도착")
            print(noteResponse)
            self?.loadNotes()
        }

    }

}


extension CreateViewController: HSCycleGalleryViewDelegate {
    func changePageControl(currentIndex: Int) {
        pageControl.currentPage = currentIndex
    }

    func numberOfItemInCycleGalleryView(_ cycleGalleryView: HSCycleGalleryView) -> Int {
        let count = notes.count
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        return count
    }

    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = cycleGalleryView.dequeueReusableCell(withIdentifier: "PagerCell", for: IndexPath(item: index, section: 0)) as! PagerCell

        let note = notes[index]

        cell.setImage(url: note.image)
        cell.titleLabel.text = note.title


        return cell
    }

    // 클릭 이벤트 함수
    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, didSelectItemCell cell: UICollectionViewCell, at Index: Int) {
        print("\(Index)번 째 Cell 이 클릭되었습니다.")
        let note = notes[Index]
        print("제목: \(note.title)")
    }

}
