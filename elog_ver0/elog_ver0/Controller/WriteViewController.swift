//
//  WriteViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/05/17.
//

import UIKit
import Floaty
import DropDown
import BTNavigationDropdownMenu

class WriteViewController: UIViewController, FloatyDelegate{

    var floaty = Floaty()
    
    let transiton = SlideInTransition()
    var topView: UIView?

    var note: Note? = UserManger.shared.currentNote
    var writings : [Writing] = []
    
    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutFAB()
        //floaty.addDragging()
        
        loadWritings()
        
        
        beforeTransition()
        //hideKeyboard()

        
    }

    //기존 저장! 버튼 (floaty 때문에 안먹음)
//    @IBAction func onClick(_ sender: Any) {
//        print("저장! 버튼 클릭하였습니당")
//        let newWritings = textView.text ?? ""
//        print(newWritings)
//
//        putWritings(title: "anytitle", subtitle: " ", content: newWritings, img: " ")
//
//    }
    
    @IBAction func didTapSave(_ sender: Any) {
        print("저장버튼 클릭되었습니다.")
        let newWritings = textView.text ?? ""
        print(newWritings)
        
        putWritings(title: "anytitle", subtitle: " ", content: newWritings, img: " ")
    }
    
//    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
//        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
//        menuViewController.didTapMenuType = { menuType in
//            self.transitionToNew(menuType)
//        }
//        menuViewController.modalPresentationStyle = .overCurrentContext
//        menuViewController.transitioningDelegate = self
//        present(menuViewController, animated: true)
//    }
    
    func beforeTransition() {
        self.title = note?.title
        noteTitle.text = note?.title
        self.noteDate.text = note?.created_at
        
        textView.text="안녕! 무엇을 더 입력할까?"
        textView.text.append("\n\n")
        
    }
    
//    func transitionToNew(_ menuType: MenuType) {
//        // title 표시하는 부분
//        let title = String(describing: menuType).capitalized
//        self.title = title
//
//        topView?.removeFromSuperview()
//        switch menuType {
//        //            case .profile:
//        //                // Storyboard에서 뷰 컨트롤러에서 identifier가 미리 설정이 되어있어야 한다.
//        //                let webPage = self.storyboard?.instantiateViewController(withIdentifier: "MonthlyViewController")
//        //                // B 컨트롤러 뷰로 넘어간다.
//        //                self.present(webPage!, animated: true, completion: nil)
//        //            let view = UIView()
//        //            view.backgroundColor = .yellow
//        //            view.frame = self.view.bounds
//        //            self.view.addSubview(view)
//        //            self.topView = view
//        //        case .camera:
//        //            let view = UIView()
//        //            view.backgroundColor = .blue
//        //            view.frame = self.view.bounds
//        //            self.view.addSubview(view)
//        //            self.topView = view
//        default:
//            break
//        }
//    }

}

extension WriteViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
    
    func layoutFAB() {
        //      let item = FloatyItem()
        //      item.hasShadow = false
        //      item.buttonColor = UIColor.yellow
        //      item.circleShadowColor = UIColor.red
        //      item.titleShadowColor = UIColor.blue
        //      item.titleLabelPosition = .right
        //      item.title = "titlePosition right"
        //      item.handler = { item in
        //
        //      }

        
        floaty.hasShadow = false
        //floaty.addItem(title: "I got a title")
//        floaty.addItem("오프라인 글 삽입", icon: UIImage(named: "camIcon"))
        floaty.addItem("오프라인 글 삽입", icon: UIImage(named: "camIcon")) { item in
            let alert = UIAlertController(title: "안녕", message: "여기 카메라 켜질거야", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            //카메라 사용가능한지 체크
//            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.sourceType = .camera
////            imagePickerController.delegate = self
//            imagePickerController.allowsEditing = false
//            self.present(imagePickerController, animated: true)
            
            //imagePickerController.allowsEditing = true // 촬영 후 편집할 수 있는 부분이 나온다.
        
        }
        
        
        floaty.addItem("갤러리", icon: UIImage(named: "folderIcon")) { item in
//            let alert = UIAlertController(title: "안녕", message: "여기 갤러리 켜질거야", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "imagePickerController") as! ImagePickerController
            self.present(secondViewController, animated: true, completion: nil)
            
            
            
            
        }
        //floaty.addItem(item: item)
        //floaty.paddingX = self.view.frame.width/2 - floaty.frame.width/2
        floaty.paddingY = self.view.frame.height/10
        floaty.fabDelegate = self

        floaty.buttonColor = UIColor.gray
        //floaty.buttonImage = UIImage(named : "2")

        self.view.addSubview(floaty)
        floaty.frame = view.bounds
    }
    
    
    func loadWritings(){
        print("Writings 로드 시작~!")
        
        NetworkManager.getAllWritings(noteIdx: note!.id) { [weak self] allWritings in
            guard let self = self else { return }
            let writings = allWritings?.result ?? []
            self.writings = writings
            print("전체 글 : \(writings)")
            print("content only : ")
            for i in 0..<writings.count{
                print(writings[i].content)
                self.textView.text.append("\n" + writings[i].content)
            }
     
            
            //pager 안써서 무시?
            // 그 다음 reloadData 를 해줘야지만 ui가 갱신됩니다.
//            self.pager.reloadData()

        }
    }
    
    func putWritings(title: String?, subtitle: String?, content: String, img: String?){
        print("Writings 추가 하기~!")
        
        let note_id = note?.id
        let newWritings = textView.text ?? ""
        let content = newWritings
        
        NetworkManager.createWritings(title: title ?? "", subtitle: subtitle ?? "", content: content, img: img ?? "", note_id: note_id!){  allWritings in
            print("note에 글 추가 api 도착")
            
//            self?.loadWritings()
        }
            

        }
    
}
